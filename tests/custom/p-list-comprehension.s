fdef main() {
    a := [x * 3 for x of range(100)];
    a := [x * 3 for x of range(100, foo)];
    a := [x * 3 for x of range(100, foo, 29)];
    a := [x * 3 for x of range(100, foo, 29), if T];
    a := [x * 3 for x of range(100), if x / 2 = 5];
};