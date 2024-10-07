input TEX;
input Pack/cmarrows/cmarrows;
defaultscale := 1.5pt;


setup_cmarrows(
brace_name = "extensiblebrace";
parameter_file = "cmr9.mf";
macro_name = "bracea");

setup_cmarrows(
arrow_name = "texarrow";
parameter_file = "cmr10.mf";
macro_name = "arrowa");

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

def draw_vector_dashed(expr B, A, pic) =
pair f!, g!;
f! = A + dir(angle(B-A) + 30)*.3*u;
g! = A + dir(angle(B-A) - 30)*.3*u;
draw f!--A--g!;
draw B--A dashed pic;
enddef;

def draw_angle(expr B, A, C,b,n,k) =
begingroup
path p[]; 
pair S[],T[],Q[];
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

beginfig(1);
pair A,B,C,D,E,X,Y,K,L,M;
A = (0,0); B = (-3*u, 4*u); D = (3*u,0); C = (-1*u, 3*u);

X = (0, 6*u);
pickup pencircle scaled .2pt;
draw A--B--(B+D)--D--cycle;
draw (B+D)--(C+B+D)--(C+D)--D;
pickup pencircle scaled .4pt;
draw (D+B)--D;
picture Pi;
Pi = TEX("$\pi_2$");
draw Pi shifted ((D + B+D+C)/2 - (0, .5u));
label(TEX("$\pi_1$"), (B+D)/2);
label.llft(TEX("$l$"), (B+D+D)/2);
endfig;

beginfig(2);
pair A,B,C,D,E,X,Y,K,L,M;
A = (0,0); B = (-3*u, 3*u); D = (3*u,0); C = (-1*u, 3*u);

X = (0, 4*u);
pickup pencircle scaled .2pt;
draw A--B--(B+D)--D--cycle;
draw (A+X)--(B+X)--(X+B+D)--(X+D)--cycle;
pickup pencircle scaled .4pt;
draw (D+B)--D;
draw (D+B+X)--(D+X);
picture Pi;
Pi = TEX("$\pi_2$");
draw Pi shifted ((D + B+X+X)/2);
label(TEX("$\pi_1$"), (B+D)/2);
label.llft(TEX("$l$"), (B+D+D)/2);
label.llft(TEX("$l$"), (B+D+D +X+X)/2);
endfig;

beginfig(3);
pair A,B,C,D,E,O,X,Y,K,L,M;
A:=(0*u,0); B:=(-6*u,-8*s); C:=(6*u,7*s); D:=(12*u,0*s); E := (11*u,-4*u);
X := A + dir(angle(B-A))*(arclength(A--B)/2);
Y := A + dir(angle(D-A))*(arclength(A--D)/2);

pair AA,BB,CC,DD;
AA = B + (-7*u,2*u); BB = AA + dir(angle(A-B))*(arclength(A--B)*2/2);
CC = BB + dir(angle(D-A))*(arclength(A--D)*2);
DD = CC - dir(angle(A-B))*(arclength(A--B)*2/2);
O = AA - (-10*u,2*u);

pickup pencircle scaled .4pt;
draw AA--BB--CC--DD--cycle;
pickup pencircle scaled .6pt;
pickup pencircle scaled .8pt;

K = (O--A) intersectionpoint (AA--DD);
L = (O--C) intersectionpoint (AA--DD);
M = (CC+DD+A)/3;

pickup pencircle scaled 1pt;

draw L--O--K;
draw_vector(L + dir(angle(C-L))*(arclength(L--C)/5),C);
draw L--(L + dir(angle(C-L))*(arclength(L--C)/5)) dashed evenly;
draw_vector_dashed(K, A, evenly);

draw_vector(M, (M+(0, 8*u)));
draw_vector(A, Y);
draw_vector(A, C);

pickup pencircle scaled .3pt;
draw_h(C,A,D,.5);

pickup pencircle scaled .7pt;
label.lft(TEX("$X_0$") scaled 2, A);
label.rt(TEX("$X_1$") scaled 2, Y);
label.top(TEX("$X$") scaled 2, C);



label.llft(TEX("$O$") scaled 2, O);
label.ulft(TEX("$\vec{r_0}$") scaled 2, O + dir(angle(A-O))*(arclength(A--O)/2));	
label.top(TEX("$\vec{b}$") scaled 2, A + dir(angle(D-A))*(arclength(A--X)*1.5/2));
endfig;

beginfig(4);
pair A,B,C,D,E,X,Y,K,L,M;
A = (0,0); B = (-3*u, 4*u); D = (3*u,0); C = (0*u, 3*u);

X = (0, 6*u);
pickup pencircle scaled .2pt;
draw A--B--(B+D)--D--cycle;
draw (B+D)--(C+B+D)--(C+D)--D;
pickup pencircle scaled .4pt;
draw (D+B)--D;

M = (C+B+D+C+D)/2;
K = (B+D+D)/2;
L = B/2;

draw M--K--L;
draw (K+dir(angle(M-K))*u/3)--((K+dir(angle(M-K))*u/3) + dir(angle(K-D))*u/3)--(K+ dir(angle(K-D))*u/3);
draw (K+dir(angle(L-K))*u/3)--((K+dir(angle(L-K))*u/3) + dir(angle(D-K))*u/3)--(K+ dir(angle(D-K))*u/3);

picture Pi;
Pi = TEX("$\pi_2$");
draw Pi shifted ((D + B+D+C)*3/4 - (0, .5u));
label.lft(TEX("$\pi_1$"), B/2);
endfig;

beginfig(5);
pair O,A,B,C,D,E,X,Y,K,L,M;
O = (0,0); A = (5*u,0); B = (0, 3*u);
C = (2*u, 3*u); D = (5*u, 3*u);
K = (A--B) intersectionpoint (O--C);
M = (A--B) intersectionpoint (O--D);
draw A--B;
arrowa C--(C+dir(angle(A-B))*u);
arrowa O--M;
arrowa O--K;
label.urt(TEX("$\vec{a}$"), C);
label.urt(TEX("$l$"), B);
label.urt(TEX("$X$") scaled .7, K);
label.urt(TEX("$X_0$") scaled .7, M);
label.llft(TEX("$O$"), O);
endfig;

beginfig(6);
pair O,A,B,C,D,E,X,Y[],K,L,M;
O = (0,0); A = (10*u,0); B = (0, 6*u);
C = (2*u, 8*u); D = (7*u, 6*u);

draw D--O;
pickup pencircle scaled .4pt;

X = h(C,D,O);
Y1 = (D--O) intersectionpoint (A--B);
draw_angle(D,Y1,A,false,1,.4);

draw A--B;
label.urt(TEX("$l_1$"), B);
label.rt(TEX("$\varphi$"), Y1) shifted (.7u,0);
label.urt(TEX("$l_2$"), D);
endfig;

beginfig(7);
pair O,A,B,C,D,E,X,Y,K,L,M;
O = (0,0); A = (10*u,0); B = (0, 6*u);
C = (4*u, 6*u); D = (7*u, 6*u);
K = (A--B) intersectionpoint (O--C);
L = h(D,A,B);
M = D + K - L;
Y = D + dir(angle(L-K))*arclength(L--K)*3/4;
arrowa K--M;
arrowa K--D;
pickup pencircle scaled .5pt;
draw_h(D,A,K,.3);
pickup pencircle scaled .3pt;
draw D--Y--((K + 3L)/4) dashed evenly scaled 1.5;
pickup pencircle scaled .7pt;
arrowa K--((K + 3L)/4);
draw A--B;
draw_vector(O,K);
pickup pencircle scaled .4pt;
draw_vector_dashed(O,D, evenly scaled .5)

label.urt(TEX("$l$"), B);
label.lft(TEX("$X_0$"), K);
label.rt(TEX("$O$"), O);
label.ulft(TEX("$\vec{r_0}$"), O + dir(angle(K-O))*arclength(K--O)/2);
label.lrt(TEX("$\vec{r}$"), O + dir(angle(D-O))*arclength(K--O)/2);
label.ulft(TEX("$\vec{n}$"), K + dir(angle(M-K))*u);
label.top(TEX("$\vec{a}$"), K + dir(angle(L-K))*arclength(K--L)/2);
label.rt(TEX("$h$"), L + dir(angle(D-L))*arclength(D--L)/2);
label.urt(TEX("$X_1$"), D);
endfig;

beginfig(8);
pair A,B,C,D,E,X,Y,K,L,M;
A:=(2*u,0); B:=(-3*u,-5*s); C:=(5*u,5*s); D:=(12*u,0*s); E := (2*u,4*u);
X := A + dir(angle(B-A))*(arclength(A--B)/2);
Y := A + dir(angle(D-A))*(arclength(A--D)/2);

pair AA,BB,CC,DD,KK,LL;
AA = B + (-7*u,-1*u); BB = AA + dir(angle(A-B))*(arclength(A--B)*3/2);
CC = BB + dir(angle(D-A))*(arclength(A--D)*2);
DD = CC - dir(angle(A-B))*(arclength(A--B)*3/2);

pickup pencircle scaled .4pt;

draw Y--Y+X-A--X dashed evenly;
draw Y+C-A--C--X+C-A--X+Y+C-A-A--Y+C-A;
draw X--X+C-A dashed evenly;
draw C+Y-A--Y--X+Y-A--X+Y+C-A-A dashed evenly;
pickup pencircle scaled .8pt;

draw A--C;
draw_vector(A, X);
draw_vector(A, Y);
draw_vector(C,X+C-A);
draw_vector(A,C);

path p;
pickup pencircle scaled .4pt;
p = (C + dir(angle(X-A))*arclength(A--Y)*2.3)--(C - dir(angle(X-A))*arclength(A--Y));
draw (point .25 of p)--(point .9 of p);
draw p shifted (D*1.5);
draw p shifted (-D*0.2);
draw (point 0 of (p shifted (D*1.5)))--(point 0 of (p shifted (-D*0.2)));
draw (point 1 of (p shifted (D*1.5)))--(point 1 of (p shifted (-D*0.2)));
draw A-.5Y--A+1.5*Y dashed evenly scaled 2;

KK = (p shifted (-D*0.2)) intersectionpoint (BB--CC);
LL = ((point 0 of (p shifted (D*1.5)))--(point 0 of (p shifted (-D*0.2)))) intersectionpoint (CC--DD);
draw KK--CC--LL dashed evenly;
draw KK--BB--AA--DD--LL;

pickup pencircle scaled .7pt;
label.ulft(TEX("$X_2$") scaled 1.5, C);
label.urt(TEX("$X_1$") scaled 1.5, A) shifted (.5u,0);
label.top(TEX("$l_1$") scaled 1.5, A + Y);
label.ulft(TEX("$l_2$") scaled 1.5, (point .3 of p));
label.rt(TEX("$\vec{a_2}$") scaled 2, A + dir(angle(B-A))*(arclength(A--X)/2));
label.ulft(TEX("$\vec{a_2}$") scaled 2,  C + dir(angle(B-A))*(arclength(A--X)/2));
label.top(TEX("$\vec{a_1}$") scaled 2, A + dir(angle(D-A))*(arclength(A--Y)*1.5/2));

endfig;

end;

