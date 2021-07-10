import typing

from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def read_root() -> typing.Dict[str, str]:
    return {"Hello": "World"}
