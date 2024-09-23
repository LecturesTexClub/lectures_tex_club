%% tgbx0000.mp
%% Copyright 2006 Tommy Ekola <tek@kth.se>
%
% This work may be distributed and/or modified under the conditions of
% the LaTeX Project Public License, either version 1.3 of this license
% or (at your option) any later version.  The latest version of this
% license is in http://www.latex-project.org/lppl.txt
%
% This work has the LPPL maintenance status `maintained'.  The Current
% Maintainer of this work is Tommy Ekola.  The Base Interpreter is
% MetaPost.

save 
font_identifier, 
cmbase, 
font_size,

u, 
width_adj, 
serif_fit,
cap_serif_fit,
letter_fit,

body_height,
asc_height,
cap_height,
fig_height,
x_height,
math_axis,
bar_height,
comma_depth,
desc_depth,

crisp,
tiny,
fine,
thin_join,
hair,
stem,
curve,
ess,
flare,
dot_size,
cap_hair,
cap_stem,
cap_curve,
cap_ess,
rule_thickness,

dish,
bracket,
jut,
cap_jut,
beak_jut,
beak,
vair,
notch_cut,
bar,
slab,
cap_bar,
cap_band,
cap_notch_cut,
serif_drop,
stem_corr,
vair_corr,
apex_corr,

o,
apex_o,

slant,
fudge,
math_spread,
superness,
superpull,
beak_darkness,
ligs,

square_dots,
hefty,
serifs,
monospace,
variant_g,
low_asterisk,
math_fitting,

designsize,

generate;

vardef generate suffix g = enddef;
numeric cmbase; cmbase = 0;
string font_identifier;
vardef font_size expr g = designsize = g enddef;
boolean square_dots, hefty, serifs, monospace, variant_g, low_asterisk,
        math_fitting;
pt#:=1pt;



