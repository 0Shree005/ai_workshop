from __future__ import annotations

from typing import Any

from graphviz import Digraph

type Value = Any  # TODO: figure better way to typehint this

type Nodes = set[Value]
type Edges = set[tuple[Value, Value]]


def attribute(obj, attr: str):
    def to_str(value):
        if isinstance(value, float):
            return f"{value:.4f}"
        return str(value)

    val = getattr(obj, attr, None)
    if val is None:
        return None
    if attr == "label":
        return str(val)
    return f"{attr}: {to_str(val)}"


def trace(root: Value) -> tuple[Nodes, Edges]:
    nodes, edges = set(), set()

    def build(v: Value):
        if v not in nodes:
            nodes.add(v)
            for child in v._prev:
                edges.add((child, v))
                build(child)

    build(root)
    return nodes, edges


def get_attrs(n):
    return (
        "{ "
        + " | ".join(filter(None, [attribute(n, attr) for attr in ["label", "data", "grad"]]))
        + " }"
    )


def draw_dot(root: Value):
    dot = Digraph(format="svg", graph_attr={"rankdir": "LR"})
    nodes, edges = trace(root)
    for n in nodes:
        uid = str(id(n))
        disp = get_attrs(n)
        dot.node(uid, disp, shape="record")
        if n._op is not None:
            dot.node(uid + n._op, n._op)  # create op node if it exists
            dot.edge(uid + n._op, uid)  # connect op node with the value node
    for n1, n2 in edges:
        dot.edge(str(id(n1)), str(id(n2)) + getattr(n2, "_op", ""))
    return dot
