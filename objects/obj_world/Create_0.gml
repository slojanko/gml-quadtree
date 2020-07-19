terrain = new Quadtree(new Rect(new Vector2(10, 10), new Vector2(700, 700)), 8, 0);
performance = new Performance();
circle_caster = new CircleCaster(new Vector2(350, 350), 100, 0);
rect_caster = new RectCaster(new Vector2(350, 350), new Vector2(100, 100), 0);

tree_size = 0;
contains_caster = false;