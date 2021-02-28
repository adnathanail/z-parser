fdef seq<top> reverse (seq<top> inseq) {
    seq<top> outseq := [];
    int i := 0;
    while {
        if (len(inseq) <= i) {
            break;
        }
        outseq := inseq[i] + outseq;
        i := i + 1;
    }
    return outseq;
};

fdef main() { # Main is last.
    seq<int> a := [1,2,3];
    seq<int> b := reverse(a);
    print b;
};