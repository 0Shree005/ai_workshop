type Nodes = set[Value]
type Edges = set[tuple[Value, Value]]


def trace(root: Value) -> tuple[Nodes, Edges]:
    nodes, edges = set(), set()

    def build(v: Value):
        if v not in nodes:
            nodes.add(v)
            for child in v._prev:  # type: ignore
                edges.add((child, v))
                build(child)

    build(root)
    return nodes, edges


def draw_dot(root: Value):
    dot = Digraph(format="svg", graph_attr={"rankdir": "LR"})
    nodes, edges = trace(root)
    for n in nodes:
        uid = str(id(n))
        dot.node(uid, f"{{ {n.label} | {n.data:.4f} | grad {n.grad:.4f} }}", shape="record")  # type: ignore
        if n._op is not None:  # type: ignore
            dot.node(uid + n._op, n._op)  # create op node if it exists # type: ignore
            dot.edge(uid + n._op, uid)  # connect op node with the value node # type: ignore

    for n1, n2 in edges:
        dot.edge(str(id(n1)), str(id(n2)) + getattr(n2, "_op", ""))
    return dot
