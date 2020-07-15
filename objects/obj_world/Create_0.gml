terrain = new Quadtree(new Rect(new Vector2(0, 0), new Vector2(700, 700)), 8, 0);
performance = new Performance();
circle_caster = new CircleCaster(new Vector2(350, 350), 100, 0);

tree_size = 0;
contains_caster = false;