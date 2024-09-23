input TEX;
input Pack/cmarrows/cmarrows;
defaultscale := 1.5pt;


setup_cmarrows(
brace_name = "extensiblebrace";
parameter_file = "cmr9.mf";
macro_name = "bracea");

u:=5mm;
s:=u;
d:=40u;
e:=d;
tt:= sqrt 2;

marksize=.2*u;
def draw_mark(expr p, a) =
begingroup
save t, dm; pair dm;
t = arctime a of p;
dm = 2.7marksize*unitvector direction t of p
rotated 90;
draw (-.5dm.. .5dm) shifted point t of p;
endgroup
enddef;



def draw_marked(expr p) =
begingroup
save amid;
amid = .5*arclength p;
for i=-(n-1)/2 upto (n-1)/2:
draw_mark(p, amid+1.45marksize*i);
endfor
draw p dashed dash;
endgroup
enddef;

def draw_vector(expr B, A) =
pair f!, g!;
f! = A + dir(angle(B-A) + 30)*.3*u;
g! = A + dir(angle(B-A) - 30)*.3*u;
draw f!--A--g!;
draw B--A;
enddef;


def draw_angle(expr B, A, C,b,n,k) =
begingroup
path p[]; 
pair S[],T[],Q[];
pickup pencircle scaled .7pt;
for i = 1 upto n:
S[i] = A + dir(angle(B-A))*k*(1+i*.5)*u; 
T[i] = A + dir(angle(C-A))*k*(1+i*.5)*u;
if abs(angle(B-A) - angle(C-A)) < 180:
Q[i] = A + dir(1/2*angle(B-A)+1/2*angle(C-A))*k*(1+i*.5)*u;
else:
Q[i] = A - dir(1/2*angle(B-A)+1/2*angle(C-A))*k*(1+i*.5)*u;
fi;
p[i] = S[i]..Q[i]..T[i];
draw p[i];
endfor
x := round(abs(angle(B-A)-angle(C-A)));
if b: 
t := angle(Q[n]-A);
picture laba; 
laba = thelabel(TEX("${" & decimal(x) & "}^\circ$"), (Q[n] + .7u*dir(t)));
fill bbox laba withcolor white;
draw laba;
fi;
endgroup
enddef;

def draw_f_angle(expr B, A, C,k) = 
begingroup
path p!; 
pair S!,T!,Q!;
pickup pencircle scaled .7pt;
S! = A + dir(angle(B-A))*k*(1.5)*u; 
T! = A + dir(angle(C-A))*k*(1.5)*u;
if abs(angle(B-A) - angle(C-A)) < 180:
Q! = A + dir(1/2*angle(B-A)+1/2*angle(C-A))*k*(1.5)*u;
else:
Q! = A - dir(1/2*angle(B-A)+1/2*angle(C-A))*k*(1.5)*u;
fi;
p! = S!..Q!..T!--A--cycle;
fill p! withcolor black;
x := round(abs(angle(B-A)-angle(C-A)));
endgroup
enddef;

def draw_h(expr A,B,C,k) =
pickup pencircle scaled .7pt;
pair H!,x[];
H! = whatever[B,C] = A + whatever*dir(angle(B-A)+90-angle(A-B)+angle(C-B));
path p,a;
p := A--H!;
x1 = H! + k*u*dir(angle(A-H!));
x2 = H! + k*u*dir(angle(B-H!));
x3 = x1 + k*u*dir(angle(B-H!)) ;
a := x1--x3--x2;
draw p;
draw a;
enddef;

vardef h(expr A,B,C) = 
pair H!;
H! = whatever[B,C] = A + whatever*dir(angle(B-A)+90-angle(A-B)+angle(C-B));
H!
enddef;

vardef circdef(expr A,B,C) = 
pair N!,M!,O!;
M! = 1/2[A,B]; N! = 1/2[C,B];
O! = M! + whatever*dir(angle(A-B) - 90) = N! + whatever*dir(angle(C-B) + 90);
path p;
p := fullcircle scaled (2*arclength(O!--A)) shifted (O!);
p
enddef;

vardef incirc(expr A,B,C) = 
pair I!,H!;
I! = A + whatever*dir(1/2*angle(B-A)+1/2*angle(C-A)) = C + whatever*dir(1/2*angle(B-C)+1/2*angle(A-C));
H! = h(I!,A,B);
path p;
p := fullcircle scaled (2*arclength(I!--H!)) shifted I!;
p
enddef;


vardef cent(expr c) = 
pair a!,b!,q!,o!,m!,n!;
a! = point .1 of c;
b! = point .2 of c;
q! = point .3 of c;
m! = 1/2[a!,b!]; n! = 1/2[q!,b!];
o! = m! + whatever*dir(angle(a!-b!) - 90) = n! + whatever*dir(angle(q!-b!) + 90);
o!
enddef;


vardef tangent(expr A,o,sgn) = 
pair p!,M!,v!;
p! = cent(o);
M! = 1/2[A,p!];
path c!;
c! = halfcircle scaled (arclength(A--p!)) rotated(90 + 90* sgn + angle(A-p!)) shifted M!;
v! = c! intersectionpoint o;
draw A--v!;
v!
enddef;

beginfig(0);

pair A,B,C,D;
A:=(0,0); B:=(5*u,3*s); C:=(12*u,3*s); D:=(7*u,0*s);

pickup pencircle scaled 1pt;
draw_vector(A, B);
draw A--B--C--D--cycle;
draw_vector(D, C);

pickup pencircle scaled .7pt;

label.ulft(TEX("$Y$") scaled 2, B);
label.llft(TEX("$X$") scaled 2, A);
label.urt(TEX("$Y'$") scaled 2, C);
label.lrt(TEX("$X'$") scaled 2, D);

endfig;

beginfig(1);

pair A,B,C,D;
A:=(0,0); B:=(5*u,3*s); C:=(12*u,3*s); D:=(7*u,0*s);

pickup pencircle scaled 1pt;
draw_vector(A, B);
draw A--B--C--D--cycle;
draw_vector(D, C);

pickup pencircle scaled .7pt;
label.ulft(TEX("$\vec{a}$") scaled 2, A + dir(angle(B-A))*u);

label.urt(TEX("$Y$") scaled 2, C);
label.lrt(TEX("$X$") scaled 2, D);

endfig;

beginfig(2);

pair A,B,C,D,X,Y,Z;
A:=(0,0); B:=(5*u,3*s); C:=(12*u,3*s);
D := (4*u,-10*s);
X := A + D;
Y := B + D;
Z := C + D;

pickup pencircle scaled 1pt;
draw_vector(A, B);
draw_vector(B, C);
draw_vector(A, C);
draw_vector(X, Y);
draw_vector(X, Z);
draw_vector(Y, Z);

path p;
p = incirc(A,B,C);

pair T,S;
T = cent(p);
S := T + D;



pickup pencircle scaled .4;
draw_vector(T,S);
pickup pencircle scaled .7pt;
label.ulft(TEX("$\vec{a}$") scaled 2, A + dir(angle(B-A))*(arclength(A--B)/2));
label.ulft(TEX("$\vec{b}$") scaled 2, B + dir(angle(C-B))*(arclength(B--C)/2));
label.lrt(TEX("$\vec{a} + \vec{b}$") scaled 2, A + dir(angle(C-A))*(arclength(C--A)/2));

label.ulft(TEX("$\vec{a}$") scaled 2, X + dir(angle(B-A))*(arclength(A--B)/2));
label.ulft(TEX("$\vec{b}$") scaled 2, Y + dir(angle(C-B))*(arclength(B--C)/2));
label.lrt(TEX("$\vec{a} + \vec{b}$") scaled 2, X + dir(angle(C-A))*(arclength(C--A)/2));

label.ulft(TEX("$X$") scaled 2, A);
label.top(TEX("$Y$") scaled 2, B);
label.urt(TEX("$Z$") scaled 2, C);
label.ulft(TEX("$X'$") scaled 2, X);
label.top(TEX("$Y'$") scaled 2, Y);
label.urt(TEX("$Z'$") scaled 2, Z);


endfig;

beginfig(3);

pair A,B,C,D,X,Y,S,T;
A:=(0,0); B:=(5*u,3*s); 
C:= A + dir(angle(B-A))*(arclength(A--B)*1.5);
X := A + dir(angle(B-A) + 90)*(.3*u);
Y:= B + dir(angle(B-A) + 90)*(.3*u);
S := A + dir(angle(B-A) - 90)*(.3*u);
T:= C + dir(angle(B-A) - 90)*(.3*u);

pickup pencircle scaled 1pt;
draw_vector(A, B);
draw_vector(A, C);

pickup pencircle scaled .4pt;
bracea X--Y;
bracea T--S;
pickup pencircle scaled .7pt;
label.ulft(TEX("$\vec{a}$") scaled 2, X + dir(angle(B-A))*(arclength(A--B)/2));
label.lrt(TEX("$\vec{b}$") scaled 2, S + dir(angle(C-A))*(arclength(A--C)/2));

label.ulft(TEX("$X$") scaled 2, A);
label.top(TEX("$Y$") scaled 2, B);
label.urt(TEX("$Z$") scaled 2, C);

endfig;


beginfig(4);

pair A,B,C,D;
A:=(0,0); B:=(5*u,4*s); C:=(11*u,4*s); D:=(6*u,0*s);


pickup pencircle scaled .8pt;
draw_vector(A, B);
draw_vector(A, C);
draw_vector(B, C);
draw_vector(D, C);
draw_vector(A, D);


pickup pencircle scaled .7pt;
label.ulft(TEX("$\vec{a}$") scaled 2, A + dir(angle(B-A))*(arclength(A--B)/2));
label.ulft(TEX("$\vec{b}$") scaled 2, A + dir(angle(C-A))*(arclength(A--C)/2));
label.bot(TEX("$\vec{c}$") scaled 2, A + dir(angle(D-A))*(arclength(A--D)/2));

endfig;

beginfig(5);
pair A,B,C,D,H[];
A:=(0,0); B:=(4*u,0*s); 
C:= A + dir(angle(B-A))*(arclength(A--B)*3/2); D:=(10*u,0*s);


pickup pencircle scaled 1pt;
draw_vector(A, B);
draw_vector(B, D);
draw_vector(A, D);

pickup pencircle scaled .7pt;

label.top(TEX("$\vec{b}$") scaled 1.3, B + dir(angle(D-B))*(arclength(D--B)/2));
label.top(TEX("$\vec{a}$") scaled 1.3, A + dir(angle(B-A))*(arclength(A--B)/2));

label.top(TEX("$Y$") scaled 1.5, B);
label.urt(TEX("$Z$") scaled 1.5, D);
label.llft(TEX("$X$") scaled 1.5, A);
endfig;

beginfig(6);

pair A,B,C,D,X,Y,K,L;
A:=(0,0); B:=(-6*u,8*s); C:=(6*u,8*s); D:=(12*u,0*s);
X := A + dir(angle(B-A))*(arclength(A--B)/2);
Y := A + dir(angle(D-A))*(arclength(A--D)/2);
pickup pencircle scaled .8pt;
draw A--B--C--D--cycle dashed evenly;
draw_vector(A, X);
draw_vector(A, C);
draw_vector(A, Y);
K := (-0.2*u,-.1*u);
L := (0,-.3*u);
bracea (A + K)--(B + K);
bracea (D + L)--(A + L);


pickup pencircle scaled .7pt;
label.urt(TEX("$\vec{a_1}$") scaled 2, A + dir(angle(B-A))*(arclength(A--Y)/2));
label.ulft(TEX("$\vec{b}$") scaled 2, A + dir(angle(C-A))*(arclength(A--C)/2));
label.top(TEX("$\vec{a_2}$") scaled 2, A + dir(angle(D-A))*(arclength(A--X)/2));
label.llft(TEX("$\vec{b_1}$") scaled 2, A + K + dir(angle(B-A))*(arclength(A--B)/2));
label.bot(TEX("$\vec{b_2}$") scaled 2, A + L*1.5 + dir(angle(D-A))*(arclength(A--D)/2));

label.top(TEX("$Y_1$") scaled 2, Y);
label.urt(TEX("$Y_2$") scaled 2, X);
label.top(TEX("$Z$") scaled 2, C);
label.lrt(TEX("$Z_1$") scaled 2, D);
endfig;

beginfig(7);

pair A,B,C,D,E,X,Y,K,L;
A:=(0,0); B:=(-6*u,-8*s); C:=(-3*u,5*s); D:=(12*u,0*s); E := (11*u,6*u);
X := A + dir(angle(B-A))*(arclength(A--B)/2);
Y := A + dir(angle(D-A))*(arclength(A--D)/2);

pair AA,BB,CC,DD;
AA = B + (-4*u,-2*u); BB = AA + dir(angle(A-B))*(arclength(A--B)*3/2);
CC = BB + dir(angle(D-A))*(arclength(A--D)*2);
DD = CC - dir(angle(A-B))*(arclength(A--B)*3/2);

pickup pencircle scaled .4pt;
draw AA--BB--CC--DD--cycle;
pickup pencircle scaled .6pt;
draw_vector (A,(E-C*1.8));
pickup pencircle scaled .8pt;

draw_vector(A, X);
draw_vector(A, C);
draw_vector(A, Y);
draw_vector(A,E);

draw E--(E-C*1.8) dashed evenly;

K := (0.2*u,.1*u);
L := (0,-.2*u);

bracea (E + K)--((E-C*1.8) + K);

pickup pencircle scaled .7pt;
label.ulft(TEX("$\vec{a_1}$") scaled 2, A + dir(angle(B-A))*(arclength(A--Y)/2));
label.urt(TEX("$\vec{a_3}$") scaled 2, A + dir(angle(C-A))*(arclength(A--C)/2));
label.top(TEX("$\vec{a_2}$") scaled 2, A + dir(angle(D-A))*(arclength(A--X)*1.5/2));

label.urt(TEX("$\vec{b_2}$") scaled 2, E - L*1.5 + dir(angle(-C))*(arclength(A--C)*1.8/2));
label.llft(TEX("$\vec{b_1}$") scaled 2, A + L*1.5 + dir(angle(E-C*1.8-A))*(arclength(A--(E-C*1.8))/2));
label.ulft(TEX("$\vec{b}$") scaled 2, A + dir(angle(E-A))*(arclength(A--E)/2));

label.rt(TEX("$Y_1$") scaled 2, Y);
label.lft(TEX("$X$") scaled 2, A-(.1*u,0));
label.lrt(TEX("$Y_2$") scaled 2, X);
label.top(TEX("$Y_3$") scaled 2, C);
label.lrt(TEX("$Z_1$") scaled 2, (E-C*1.8));
label.top (TEX("$Z$") scaled 2, E);
label.top (TEX("$(X,Y_1,Y_2)$") scaled 1.5, DD scaled .8);
endfig;

beginfig(8);
pair A,B,C,D,H[];
A:=(0,0); B:=(7*u,5*s); 
C:= A + dir(angle(B-A))*(arclength(A--B)*3/2); D:=(10*u,0*s);


pickup pencircle scaled 1pt;
draw_vector(A, B);
draw_vector(B, D);
draw_vector(A, D);

pickup pencircle scaled .7pt;

label.ulft(TEX("$A$") scaled 1.5, B);
label.urt(TEX("$B$") scaled 1.5, D);
label.llft(TEX("$O$") scaled 1.5, A);
endfig;

beginfig(9);
pair A,B,C,D,H[];
A:=(0,0); B:=(4*u,5*s); 
n := 1/3;
D:=(10*u,0*s);
C:= B + dir(angle(D-B))*(arclength(D--B)*n); 
pickup pencircle scaled 1pt;
draw B--D;
draw_vector(A, B);
draw_vector(A, C);
draw_vector(A, D);

pickup pencircle scaled .7pt;
label.urt(TEX("$\lambda$") scaled 1.3, B + dir(angle(C-B))*(arclength(C--B)/2));
label.urt(TEX("$\mu$") scaled 1.3, D + dir(angle(C-D))*(arclength(C--D)/2));
label.lrt(TEX("$\vec{c}$") scaled 1.3, A + dir(angle(C-A))*(arclength(C--A)*1.5/2));
label.ulft(TEX("$\vec{a}$") scaled 1.3, A + dir(angle(B-A))*(arclength(A--B)/2));
label.ulft(TEX("$\vec{b}$") scaled 1.3, A + dir(angle(D-A))*(arclength(A--D)/2));
label.ulft(TEX("$A$") scaled 1.5, B);
label.urt(TEX("$C$") scaled 1.5, C);
label.urt(TEX("$B$") scaled 1.5, D);
label.llft(TEX("$O$") scaled 1.5, A);
endfig;

beginfig(10);
pair A,B,C,D,AA,BB,CC,I;
A:=(0,0); B:=(4*u,0*s); 
C:= (0,4*u); D:=(7*u,3*s);
AA = D;
BB = B rotated -30 + D;
CC = C rotated -30 + D;
I = (3*u,5*u);

pickup pencircle scaled 1pt;
draw_vector(A, B);
draw_vector(AA, BB);
draw_vector(AA, CC);
draw_vector(A, C);

pickup pencircle scaled .7pt;
draw_vector(A, I);
draw_vector(AA, I);

label.lft(TEX("$\vec{e_2}$") scaled 1.3, A + dir(angle(C-A))*(arclength(A--C)/2));
label.top(TEX("$\vec{e_1}$") scaled 1.3, A + dir(angle(B-A))*(arclength(A--B)/2));
label.urt(TEX("$\vec{e_1'}$") scaled 1.3, AA + dir(angle(BB-AA))*(arclength(AA--BB)/2));
label.ulft(TEX("$\vec{e_2'}$") scaled 1.3, AA + dir(angle(CC-AA))*(arclength(AA--BB)/2));
label.top(TEX("$A$") scaled 1.5, I);
label.llft(TEX("$O'$") scaled 1.5, D);
label.llft(TEX("$O$") scaled 1.5, A);
endfig;

beginfig(11);
pair A,B,C,D,H[];
A:=(0,0); B:=(7*u,5*s); 
C:= A + dir(angle(B-A))*(arclength(A--B)*3/2); D:=(10*u,0*s);


pickup pencircle scaled 1pt;
draw_vector(A, B);
draw D--A--B;
draw_vector(A, D);

H1 = h(B,A,D);
draw B--H1 dashed evenly;
pickup pencircle scaled .7pt;
label.ulft(TEX("$\vec{a_1}$") scaled 1.3, A + dir(angle(B-A))*(arclength(A--B)/2));

label.top(TEX("$pr_{\vec{b}}\vec{a_1}$") scaled 1.3, A + dir(angle(D-A))*(arclength(A--H1)*1.3/2));



label.ulft(TEX("$A$") scaled 1.5, B);
label.urt(TEX("$\vec{b}$") scaled 2, D);
label.llft(TEX("$O$") scaled 2, A);
label.bot(TEX("$\tilde{A}$") scaled 1.5, H1);
endfig;

beginfig(12);
pair A,B,C,D,H[];
A:=(0,0); B:=(12*u,5*s); C:=(5*u,9*s); D:=(15*u,0*s);


pickup pencircle scaled 1pt;
draw_vector(A, B);
draw D--A--B--C;
draw_vector(B, C);
draw_vector(A, D);
draw_vector(A, C);

H1 = h(B,A,D);
H2 = h(C,A,D);
draw B--H1 dashed evenly;
draw C--H2 dashed evenly;
pickup pencircle scaled .7pt;
label.top(TEX("$\vec{a_1}$") scaled 2, A + dir(angle(B-A))*(arclength(A--B)/2));
label.urt(TEX("$\vec{a_2}$") scaled 2, B + dir(angle(C-B))*(arclength(C--B)/2));
label.top(TEX("$\vec{a_1} + \vec{a_2}$") scaled 2, A  ) rotated angle(C-A) shifted (A + dir(angle(C-A))*(arclength(A--C)/2));
label.bot(TEX("$pr_{\vec{b}}\vec{a_1}$") scaled 1.3, A + dir(angle(D-A))*(arclength(A--H1)/2)) shifted (0, -2.2*u);
label.top(TEX("$pr_{\vec{b}}\vec{a_2}$") scaled 1.3, H1 + dir(angle(H2-H1))*(arclength(H1--H2)/2));

bracea (H1--A) shifted (0,-2*u);

label.urt(TEX("$A_2$") scaled 2, C);
label.rt(TEX("$A_1$") scaled 2, B);
label.urt(TEX("$\vec{b}$") scaled 2, D);
label.llft(TEX("$O$") scaled 2, A);
label.bot(TEX("$\tilde{A_1}$") scaled 2, H1);
label.bot(TEX("$\tilde{A_2}$") scaled 2, H2);
endfig;

beginfig(13);
pair A,B,C,D,H[];
A:=(0,0); B:=(7*u,5*s); 
C:= A + dir(angle(B-A))*(arclength(A--B)*3/2); D:=(15*u,0*s);


pickup pencircle scaled 1pt;
draw_vector(A, B);
draw D--A--B--C;
draw_vector(B, C);
draw_vector(A, D);

H1 = h(B,A,D);
H2 = h(C,A,D);
draw B--H1 dashed evenly;
draw C--H2 dashed evenly;
pickup pencircle scaled .7pt;
label.ulft(TEX("$\vec{a}$") scaled 1.3, A + dir(angle(B-A))*(arclength(A--B)/2));
label.ulft(TEX("$\vec{\lambda a}$") scaled 1.3, B + dir(angle(C-B))*(arclength(C--B)/2));

label.top(TEX("$pr_{\vec{b}}\vec{a}$") scaled 1.3, A + dir(angle(D-A))*(arclength(A--H1)*1.5/2));
label.top(TEX("$pr_{\vec{b}}\vec{\lambda a}$") scaled 1.3, H1 + dir(angle(H2-H1))*(arclength(H1--H2)/2));

label.ulft(TEX("$A'$") scaled 1.5, C);
label.ulft(TEX("$A$") scaled 1.5, B);
label.urt(TEX("$\vec{b}$") scaled 1.5, D);
label.llft(TEX("$O$") scaled 1.5, A);
label.bot(TEX("$\tilde{A}$") scaled 1.5, H1);
label.bot(TEX("$\tilde{A'}$") scaled 1.5, H2);
endfig;






end;

