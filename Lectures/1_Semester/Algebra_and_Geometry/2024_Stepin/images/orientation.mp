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

beginfig(1);
pair A,B,C,D,E,X,Y,K,L;
A:=(0,0); B:=(-6*u,-8*s); C:=(-3*u,5*s); D:=(12*u,0*s); E := (11*u,-4*u);
X := A + dir(angle(B-A))*(arclength(A--B)/2);
Y := A + dir(angle(D-A))*(arclength(A--D)/2);

pair AA,BB,CC,DD;
AA = B + (-4*u,-2*u); BB = AA + dir(angle(A-B))*(arclength(A--B)*3/2);
CC = BB + dir(angle(D-A))*(arclength(A--D)*2);
DD = CC - dir(angle(A-B))*(arclength(A--B)*3/2);

pickup pencircle scaled .4pt;
draw AA--BB--CC--DD--cycle;
pickup pencircle scaled .6pt;
pickup pencircle scaled .8pt;

draw_vector(A, X);
draw_vector(A, Y);

pair XX,YY,KK,LL;
XX := E + dir(angle(B-A))*(arclength(A--B)/2);
YY := E + dir(angle(D-A))*(arclength(A--D)/2);

KK := E + dir(angle(B-A))*(arclength(A--B) / 10);
LL := E + dir(angle(D-A))*(arclength(A--D) / 10);

draw_vector(E,XX);
draw_vector(E,YY);

K := A + dir(angle(B-A))*(arclength(A--B) / 10);
L := A + dir(angle(D-A))*(arclength(A--D) / 10);

arrowa K..{up}L;
arrowa LL{down}..KK;

pickup pencircle scaled .7pt;
label.ulft(TEX("$\vec{a}$") scaled 2, A + dir(angle(B-A))*(arclength(A--Y)/2));
label.ulft(TEX("Positive orientation") scaled 1, (X + Y) / 2 + Y*2/3);
label.top(TEX("$\vec{b}$") scaled 2, A + dir(angle(D-A))*(arclength(A--X)*1.5/2));

label.ulft(TEX("$\vec{b_1}$") scaled 2, E + dir(angle(B-A))*(arclength(A--Y)/2));
label.ulft(TEX("Negative orientation") scaled 1, (XX + YY) / 2 + Y*2.3/3);
label.top(TEX("$\vec{a_1}$") scaled 2, E + dir(angle(D-A))*(arclength(A--X)/2));
endfig;

beginfig(2);
pair A,B,C,D,E,X,Y,K,L,M;
A:=(0*u,0); B:=(-6*u,-8*s); C:=(2*u,7*s); D:=(12*u,0*s); E := (11*u,-4*u);
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

arrowa K..{up}L;
arrowa L{up}..M;

pickup pencircle scaled .7pt;
label.rt(TEX("$\vec{c}$") scaled 2, A + dir(angle(C-A))*(arclength(A--C)/2));	
label.ulft(TEX("$\vec{a}$") scaled 2, A + dir(angle(B-A))*(arclength(A--Y)/2));
label.ulft(TEX("Right three") scaled 1.5, (X + Y) / 2 + Y*2/3);
label.top(TEX("$\vec{b}$") scaled 2, A + dir(angle(D-A))*(arclength(A--X)*1.5/2));

endfig;

beginfig(3);
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

arrowa M..{down}L;
arrowa L{down}..K;

pickup pencircle scaled .7pt;
label.rt(TEX("$\vec{c}$") scaled 2, A + dir(angle(C-A))*(arclength(A--C)/2));	
label.ulft(TEX("$\vec{b}$") scaled 2, A + dir(angle(B-A))*(arclength(A--Y)/2));
label.ulft(TEX("Left three") scaled 1.5, (X + Y) / 2 + Y*2/3);
label.top(TEX("$\vec{a}$") scaled 2, A + dir(angle(D-A))*(arclength(A--X)*1.5/2));

endfig;

beginfig(4);
pair A,B,C,D,E,X,Y,K,L,M;
A:=(2*u,0); B:=(-3*u,-5*s); C:=(5*u,5*s); D:=(12*u,0*s); E := (2*u,4*u);
X := A + dir(angle(B-A))*(arclength(A--B)/2);
Y := A + dir(angle(D-A))*(arclength(A--D)/2);

pair AA,BB,CC,DD;
AA = B + (-7*u,-1*u); BB = AA + dir(angle(A-B))*(arclength(A--B)*3/2);
CC = BB + dir(angle(D-A))*(arclength(A--D)*2);
DD = CC - dir(angle(A-B))*(arclength(A--B)*3/2);

pickup pencircle scaled .4pt;
draw AA--BB--CC--DD--cycle;
pickup pencircle scaled .4pt;

draw Y--Y+X-A--X;
draw Y--Y+C-A--C--X+C-A--X+Y+C-A-A--Y+C-A;
draw X--X+C-A;
draw X+Y-A--X+Y+C-A-A;
pickup pencircle scaled .8pt;

draw_vector(A, X);
draw_vector(A, Y);
draw_vector(A, C);
draw_vector(A, E);

pickup pencircle scaled .7pt;
label.rt(TEX("$\vec{c}$") scaled 2, A + dir(angle(C-A))*(arclength(A--C)/3));	
label.ulft(TEX("$\vec{b}$") scaled 2, A + dir(angle(B-A))*(arclength(A--Y)/2));
label.lft(TEX("$\vec{n}$") scaled 2, A + dir(angle(E-A))*(arclength(A--E)/2));	
label.top(TEX("$\vec{a}$") scaled 2, A + dir(angle(D-A))*(arclength(A--X)*1.5/2));

endfig;

beginfig(5);
pair A,B,C,D,E,X,Y,K,L,M;
A:=(2*u,0); B:=(-3*u,-5*s); C:=(2*u,5*s); D:=(12*u,0*s); E := (2*u,4*u);
X := A + dir(angle(B-A))*(arclength(A--B)/2);
Y := A + dir(angle(D-A))*(arclength(A--D)/2);

pair AA,BB,CC,DD;
AA = B + (-7*u,-1*u); BB = AA + dir(angle(A-B))*(arclength(A--B)*3/2);
CC = BB + dir(angle(D-A))*(arclength(A--D)*2);
DD = CC - dir(angle(A-B))*(arclength(A--B)*3/2);


pickup pencircle scaled .8pt;

K := A + dir(angle(B-A))*(arclength(A--B)/10);
L := A + dir(angle(D-A))*(arclength(A--D)/10);
M := A + dir(angle(C-A))*(arclength(A--C)/6);

draw_vector(A, X);
draw_vector(A, Y);
draw_vector(A, C);

pickup pencircle scaled .4pt;
draw AA--BB--CC--DD--cycle;
draw K--K+M-A--M--L+M-A--L;

pickup pencircle scaled .7pt;
label.lft(TEX("$\vec{n}$") scaled 2, A + dir(angle(C-A))*(arclength(A--C)*2/3));	
label.ulft(TEX("$\vec{b}$") scaled 2, A + dir(angle(B-A))*(arclength(A--Y)/2));
label.top(TEX("$\vec{a}$") scaled 2, A + dir(angle(D-A))*(arclength(A--X)*1.5/2));

endfig;
end;

