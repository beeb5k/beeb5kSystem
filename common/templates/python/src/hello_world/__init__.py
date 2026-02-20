def hello_world(action: str):
    result = [*hello_world.__name__.split("_")]
    eval(action)(" ".join(result).title() + "!\n")
