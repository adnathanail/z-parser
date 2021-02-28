tdef person { str name, str surname, int age };

fdef main() {
	tdef family { person mother, person father, seq<person> children };
	return;
};
