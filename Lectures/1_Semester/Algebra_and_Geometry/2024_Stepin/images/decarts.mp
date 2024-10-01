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
pair O,A,B,C,D,E,X,Y,K,L,M;
O = (0,0); A = (5*u,0); B = (0, 5*u);
C = (-5*u, 0); D = (5*u, 3*u);
path p;
p := circdef(A,B,C);
draw p;
draw (A*-1.5)--O--(A*1.5);
draw (B*-1.5)--O--(B*1.5);
X = p intersectionpoint (O--D);
draw O--X;
arrowa O--1.5A;
arrowa O--1.5B;
label.urt(TEX("$(x, y)$"), X);
label.ulft(TEX("$1$"), O + dir(angle(X-O))*(arclength(O--X))/2);
endfig;

beginfig(2);
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


beginfig(3);
pair O,A,B,C,D,E,X,Y,K,L,M;
O = (0,0); A = (10*u,0); B = (0, 6*u);
C = (4*u, 6*u); D = (10*u, 6*u);
K = (A--B) intersectionpoint (O--C);
M = (A--B) intersectionpoint (O--D);
draw A--B;
arrowa K--M;
label.urt(TEX("$l$"), B);
dotlabel.llft(TEX("$X_1$"), K);
dotlabel.llft(TEX("$X_0$"), M);
label.top(TEX("$\vec{b}$"), M + dir(angle(K-M))*(arclength(M--K)/2));
endfig;

beginfig(4);
pair O,A,B,C,D,E,X,Y,K,L,M;
O = (0,0); A = (10*u,0); B = (0, 6*u);
C = (4*u, 6*u); D = (10*u, 6*u);
K = (A--B) intersectionpoint (O--C);
M = (A--B) intersectionpoint (O--D);
X = -.25A;
Y = h(X,A,B);
draw_h((Y + dir(angle(Y-X))*u),B,A,.4);
draw X--Y;
draw A--B;
draw -.5A--1.5A;
draw_angle(B,A,(1.5A),false,1,.4);
draw_angle(Y,X,(1.5A),false,2,.4);
dotlabel.bot(TEX("$\phi_1$"), A);
dotlabel.bot(TEX("$\phi_2$"), X);
label.ulft(TEX("$l_1$"), X + dir(angle(Y-X))*(arclength(X--Y)/2));
label.urt(TEX("$l_2$"), A + dir(angle(B-A))*(arclength(A--B)/2));
endfig;

beginfig(5);
pair O,A,B,C,D,E,X,Y,K,L,M;
O = (0,0); A = (5*u,0); B = (0, 5*u);
C = (-5*u, 0); D = (3*u,5*u);
draw (A*-1.5)--O--(A*1.5);
draw (B*-1.5)--O--(B*1.5);

arrowa O--1.5A;
arrowa O--1.5B;
draw D--(D-(0,10*u));
K = h(D,A,O);
label.lrt(TEX("$y$"), 1.5B);
label.llft(TEX("$a$"), K);
label.urt(TEX("$x=a$"), K + (0,u));
dotlabel.lft(TEX("X"), (D + K)/2);
label.ulft(TEX("$x$"), 1.5A);
endfig;


beginfig(6);
pair O,A,B,C,D,E,X,Y,K,L,M;
O = (0,0); A = (10*u,0); B = (0, 6*u);
C = (4*u, 6*u); D = (7*u, 6*u);
K = (A--B) intersectionpoint (O--C);
L = h(D,A,B);
M = D + K - L;
arrowa K--M;
draw_angle(D,K,M,false,1,.3);
arrowa K--D;
draw A--B;
label.urt(TEX("$l$"), B);
label.llft(TEX("$X_0$"), K);
label.ulft(TEX("$\vec{n}$"), K + dir(angle(M-K))*u);
label.urt(TEX("$X_1$"), D);
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
label.urt(TEX("$l$"), B);
label.llft(TEX("$X_0$"), K);
label.ulft(TEX("$\vec{n}$"), K + dir(angle(M-K))*u);
label.llft(TEX("$\vec{a}$"), K + dir(angle(L-K))*arclength(K--L)/2);
label.rt(TEX("$h$"), L + dir(angle(D-L))*arclength(D--L)/2);
label.urt(TEX("$X_1$"), D);
endfig;

beginfig(8);
pair O,A,B,C,D,E,X,Y[],K,L,M;
O = (0,0); A = (10*u,0); B = (0, 6*u);
C = (2*u, 8*u); D = (7*u, 6*u);
K = (A--B) intersectionpoint (O--C);
L = h(D,A,B);
M = D + K - L;
draw D--O;
pickup pencircle scaled .4pt;
arrowa K--M;
X = h(C,D,O);
Y1 = (D--O) intersectionpoint (A--B);
Y2 = (X--C) intersectionpoint (K--M);
draw_angle(D,Y1,A,false,1,.4);
draw_angle(X,Y2,K,false,1,.4);
draw_h(C,O,D,.3);
draw_h(M,A,B,.3);
arrowa X--C;
draw A--B;
label.urt(TEX("$l$"), B);
label.rt(TEX("$\varphi$"), Y1) shifted (.7u,0);
label.bot(TEX("$\varphi$"), Y2) shifted (0, -.7u);
label.ulft(TEX("$\vec{n_1}$"), K + dir(angle(M-K))*u);
label.urt(TEX("$\vec{n_2}$"), X + dir(angle(C-X))*u);
label.urt(TEX("$l_2$"), D);
endfig;

beginfig(9);
pair A,B,C,D,E,X,Y,K,L,M;
A:=(2*u,0); B:=(-6*u,-8*s); C:=(2*u,7*s); D:=(12*u,0*s); E := (11*u,-4*u);
X := A + dir(angle(B-A))*(arclength(A--B)/2);
Y := A + dir(angle(D-A))*(arclength(A--D)/2);

pair AA,BB,CC,DD;
AA = B + (-7*u,-1*u); BB = AA + dir(angle(A-B))*(arclength(A--B)*3/2);
CC = BB + dir(angle(D-A))*(arclength(A--D)*2);
DD = CC - dir(angle(A-B))*(arclength(A--B)*3/2);

pickup pencircle scaled .4pt;
draw AA--BB--CC--DD--cycle;
pickup pencircle scaled .6pt;
pickup pencircle scaled .8pt;

draw_vector(A, X);
draw_vector(A, Y);
draw_vector(A, C);

K := A + dir(angle(B-A))*(arclength(A--B) / 10);
L := A + dir(angle(D-A))*(arclength(A--D) / 10);
M := A + dir(angle(C-A))*(arclength(A--C) / 8);

draw M--(M + dir(angle(B-A))*(arclength(A--B) / 10))--K;
draw M--(M + dir(angle(D-A))*(arclength(A--D) / 10))--L;

pickup pencircle scaled .7pt;
label.rt(TEX("$\vec{n}$") scaled 2, A + dir(angle(C-A))*(arclength(A--C)/2));	
endfig;
end;

