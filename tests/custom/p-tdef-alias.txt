fdef main() {
	tdef person { str name, str surname, int age };
	alias seq<person> people;
	tdef family { person mother, person father, seq<person> children };
	return;
};
