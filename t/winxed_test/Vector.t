$load "rosella/test.pbc";

function main[main]() {
    using Rosella.Test.test_vector;
    test_vector(function(var self, var data) {
        self.assert.equal(data[0] + data[1], data[2]);
    }, [
        [1, 2, 3],
        [2, 3, 5],
        [3, 4, 7],
        [4, 5, 9]
    ]);
}
