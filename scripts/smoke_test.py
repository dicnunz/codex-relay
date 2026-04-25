#!/usr/bin/env python3
"""Fast local checks that do not touch Telegram or Codex."""

from __future__ import annotations

import tempfile
import os
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

import codex_relay as relay


def assert_true(value: object, message: str) -> None:
    if not value:
        raise SystemExit(message)


class FakeTelegram(relay.TelegramAPI):
    def __init__(self) -> None:
        self.calls: list[tuple[str, dict[str, object]]] = []

    def call(self, method: str, params: dict[str, object] | None = None) -> dict[str, object]:
        self.calls.append((method, params or {}))
        return {"ok": True, "result": {}}


def main() -> int:
    photo_message = {
        "message_id": 1,
        "caption": "can you see this?",
        "photo": [
            {"file_id": "small", "width": 320, "height": 240, "file_size": 1000},
            {"file_id": "large", "width": 1280, "height": 720, "file_size": 4000},
        ],
    }
    specs = relay.image_attachment_specs(photo_message)
    assert_true(len(specs) == 1, "expected one selected Telegram photo")
    assert_true(specs[0]["file_id"] == "large", "expected highest-resolution photo")

    document_message = {
        "message_id": 2,
        "document": {
            "file_id": "doc-image",
            "file_name": "screen.PNG",
            "mime_type": "application/octet-stream",
            "file_size": 2000,
        },
    }
    assert_true(relay.image_attachment_specs(document_message), "expected image document support")
    assert_true(relay.image_suffix("screen.PNG") == ".png", "expected png suffix")
    assert_true(relay.image_suffix("photo.jpeg") == ".jpg", "expected jpeg normalization")

    prompt = relay.codex_prompt("what is in this image?", "main", [Path("/tmp/example.png")])
    assert_true("attached to this Codex prompt" in prompt, "expected image prompt note")
    assert_true(relay.extract_session_id("Session ID: 12345678-1234-1234-1234-123456789abc"), "expected session id")
    assert_true(relay.env_bool("MISSING_TEST_BOOL", True), "expected default bool support")

    fake = FakeTelegram()
    os.environ.pop("CODEX_TELEGRAM_REPLY_TO_MESSAGES", None)
    fake.send_message(123, "plain", 999)
    assert_true("reply_to_message_id" not in fake.calls[-1][1], "expected reply threading off by default")
    os.environ["CODEX_TELEGRAM_REPLY_TO_MESSAGES"] = "true"
    fake.send_message(123, "threaded", 999)
    assert_true(fake.calls[-1][1].get("reply_to_message_id") == 999, "expected opt-in reply threading")
    os.environ.pop("CODEX_TELEGRAM_REPLY_TO_MESSAGES", None)

    thread = {
        "name": "main",
        "workdir": "/tmp",
        "last_status": "ok",
        "last_latency_seconds": 1.2,
        "last_image_count": 1,
        "last_run_at": "2026-04-25T00:00:00+00:00",
    }
    status = relay.status_text(thread)
    assert_true("reply threading: disabled" in status, "expected reply threading status")
    assert_true("reasoning effort: xhigh" in status, "expected default xhigh reasoning status")
    assert_true("last run: ok; 1.2s; 1 image" in status, "expected last-run latency status")

    with tempfile.TemporaryDirectory() as tmp:
        target = Path(tmp) / "private.bin"
        relay.write_private_bytes(target, b"ok")
        assert_true(target.read_bytes() == b"ok", "expected private byte write")
        assert_true(oct(target.stat().st_mode & 0o777) == "0o600", "expected private file mode")

        fake_codex = Path(tmp) / "fake-codex"
        fake_codex.write_text(
            "#!/bin/sh\n"
            "out=''\n"
            "found_reasoning=0\n"
            "while [ \"$#\" -gt 0 ]; do\n"
            "  if [ \"$1\" = '--output-last-message' ]; then shift; out=\"$1\"; fi\n"
            "  if [ \"$1\" = 'model_reasoning_effort=\"xhigh\"' ]; then found_reasoning=1; fi\n"
            "  shift || true\n"
            "done\n"
            "if [ \"$found_reasoning\" != 1 ]; then echo 'missing reasoning effort' >&2; exit 7; fi\n"
            "printf 'fake answer\\n' > \"$out\"\n"
            "printf 'session id: 12345678-1234-1234-1234-123456789abc\\n' >&2\n"
        )
        fake_codex.chmod(0o700)
        old_codex_bin = os.environ.get("CODEX_BIN")
        old_reasoning = os.environ.get("CODEX_TELEGRAM_REASONING_EFFORT")
        os.environ["CODEX_BIN"] = str(fake_codex)
        os.environ["CODEX_TELEGRAM_REASONING_EFFORT"] = "xhigh"
        try:
            answer, session_id, stats = relay.run_codex("hello", {"workdir": tmp, "name": "main"})
        finally:
            if old_codex_bin is None:
                os.environ.pop("CODEX_BIN", None)
            else:
                os.environ["CODEX_BIN"] = old_codex_bin
            if old_reasoning is None:
                os.environ.pop("CODEX_TELEGRAM_REASONING_EFFORT", None)
            else:
                os.environ["CODEX_TELEGRAM_REASONING_EFFORT"] = old_reasoning
        assert_true(answer == "fake answer", "expected fake Codex answer")
        assert_true(session_id.endswith("123456789abc"), "expected captured session id")
        assert_true(stats["last_status"] == "ok", "expected ok run status")
        assert_true("last_latency_seconds" in stats, "expected latency stats")
        assert_true(stats["last_reasoning_effort"] == "xhigh", "expected reasoning stats")

    print("ok: smoke tests")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
