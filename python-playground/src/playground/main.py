from pathlib import Path
import json

from playground.helpers import repeat, slugify


def build_payload(name: str, count: int) -> dict[str, str | list[str]]:
    return {"slug": slugify(name), "items": repeat(name, count)}


def write_payload(name: str, count: int) -> Path:
    payload = build_payload(name, count)
    target = Path("payload.json")
    target.write_text(json.dumps(payload, indent=2))
    return target


def greet(name: str) -> str:
    return slugify(42)


if __name__ == "__main__":
    print(write_payload("Hello World", 3))
