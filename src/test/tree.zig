pub const BinaryNode = struct {
    value: type,
    right: ?*BinaryNode,
    left: ?*BinaryNode,

    pub fn init(comptime T: type, left: ?*BinaryNode, right: ?*BinaryNode) BinaryNode {
        return BinaryNode{
            .value = T,
            .left = left,
            .right = right,
        };
    }
};

pub const tree: BinaryNode = BinaryNode{ .value = 20, .right = BinaryNode{
    .value = 50,
    .right = BinaryNode{
        .value = 100,
        .right = null,
        .left = null,
    },
    .left = BinaryNode{ .value = 30, .right = BinaryNode{
        .value = 45,
        .right = null,
        .left = null,
    }, .left = BinaryNode{
        .value = 29,
        .right = null,
        .left = null,
    } },
}, .left = BinaryNode{ .value = 10, .right = BinaryNode{
    .value = 15,
    .right = null,
    .left = null,
}, .left = BinaryNode{
    .value = 5,
    .right = BinaryNode{
        .value = 7,
        .right = null,
        .left = null,
    },
    .left = null,
} } };

pub const tree2: BinaryNode = BinaryNode{ .value = 20, .right = BinaryNode{
    .value = 50,
    .right = null,
    .left = BinaryNode{ .value = 30, .right = BinaryNode{
        .value = 45,
        .right = BinaryNode{
            .value = 49,
            .left = null,
            .right = null,
        },
        .left = null,
    }, .left = BinaryNode{
        .value = 29,
        .right = null,
        .left = BinaryNode{
            .value = 21,
            .right = null,
            .left = null,
        },
    } },
}, .left = BinaryNode{ .value = 10, .right = BinaryNode{
    .value = 15,
    .right = null,
    .left = null,
}, .left = BinaryNode{
    .value = 5,
    .right = BinaryNode{
        .value = 7,
        .right = null,
        .left = null,
    },
    .left = null,
} } };
