def slugify(value: str) -> str:
    return value.strip().lower().replace(" ", "-")


def repeat(value: str, count: int) -> list[str]:
    return [value for _ in range(count)]
