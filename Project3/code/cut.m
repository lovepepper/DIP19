function grid= cut(ib, LTr, LTc, RBr, RBc,  flag)

grid = ib(LTr:RBr, LTc: RBc);
[r, c] = find(grid == flag);
[rectx,recty] = minboundrect(c,r,'a');
LTr = recty(1);
LTc = rectx(1);
RBr = recty(3);
RBc = rectx(3);
grid = grid(LTr:RBr, LTc:RBc);

end

