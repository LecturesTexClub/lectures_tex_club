%% tgbx0027.mp
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

vardef setup_paren (expr source_file, cmdname) =

  scantokens ("input tgbx0000");

  scantokens ("input " & source_file);

  expandafter def scantokens cmdname expr p =
    scantokens (cmdname & "__tgbxww")(p)
  enddef;

  expandafter vardef scantokens (cmdname & "__tgbxww " & "(expr apth) " &
    "text text_ = " &
  
    "save u, designsize, curve, stem, rule_thickness, eps, fine, " &
    "     fudge, hair;" &  

    "u#              := " & decimal u# & ";" &
    "designsize      := " & decimal designsize & ";" &
    "curve#          := " & decimal curve# & ";" &
    "stem#           := " & decimal stem# & ";" &
    "rule_thickness# := " & decimal rule_thickness# & ";" &
    "eps             := " & decimal eps & ";" &
    "fine#           := " & decimal fine# & ";" &
    "fudge           := " & decimal fudge & ";" &
    "hair#           := " & decimal hair# & ";" &
  
    % Time for middle piece

    "save st; numeric st;" &
    "if unknown " & cmdname & "_middle_time:" &
    "  st := arctime (arclength apth)/2 of apth;" &
    "else: st:=" & cmdname & "_middle_time; fi")

    save prevpen;
    prevpen:=savepen;

    save w; numeric w;  w :=12u#;
    save h; numeric h;  h :=0;
    save dh; numeric dh; dh:=0.6designsize;
    save dw; numeric dw; dw:=curve#-stem#;
    save d; numeric d;  d :=1.5dh;
    save bold;  numeric bold;  bold := curve#;
    save min_breadth; numeric min_breadth; 
           min_breadth:=rule_thickness#+0.6dw;
    save max_breadth; numeric max_breadth; 
           max_breadth:=bold+2dw;
    save heavy_rule_thickness; numeric heavy_rule_thickness#; 
           heavy_rule_thickness#:=3rule_thickness#;
           
    save x,y;
    numeric x[],x[]',x[]l,x[]'l,x[]r,x[]'r,
            y[],y[]',y[]l,y[]'l,y[]r,y[]'r;

    if fine#>fudge*hair#:
      fine# := fudge*hair#;
    fi
    pickup if fine#=0: nullpen else: pencircle scaled fine# fi;
	    
    penpos3(min_breadth,0);  penpos4(max_breadth,0);
    rt x3r = w-1.25u#+0.5min_breadth;  lft x4l = 1.25u#;
    bot y3=-d;  y4=h;

    penpos1(min_breadth,0);  penpos2(max_breadth,0);
    rt x1r = w-1.25u#+0.5min_breadth;  lft x2l = 1.25u#;
    top y1 = h;  y2=-d;

    save mapto, n;
    vardef mapto(text t) =
      hide(numeric n; n:=0;
           numeric x,x_[],y,y_[];
           for z=t: z_[incr n]:=z; endfor;
           transform T;
           z_2 = z_1 transformed T;
           z_4 = z_3 transformed T;
           z_6 = z_5 transformed T;)
      T
    enddef;

    %  The bottom part of the parenthesis

    save bottom_part;
    vardef bottom_part(expr T) =
      filldraw  (z3l{3(x4l-x3l),y4-y3}..{up}z4l
        --reverse(z3r{3(x4r-x3r),y4-y3}..{up}z4r)
        --cycle) transformed T text_;
    enddef;

    save f;
    vardef f(expr s) =
      abs(point 0 of apth - (point s of apth +
          (w-2.5u#+0.5min_breadth+0.5*max_breadth)
          *(unitvector (direction s of apth) rotated 90)))
      < ((h+d) ++ (w-2.5u#+0.5min_breadth+0.5*max_breadth))
    enddef;

    save tolerence;  tolerence:=epsilon;
    save s;  numeric s;

    save T;  transform T;  % transform the bottom part
    if arclength apth=0:
      T := identity shifted (point (length apth) of apth - z3r);
    elseif arclength apth < y1-y2+y4-y3:
      T := mapto(z4l,
        0.5[point 0 of apth, point (length apth) of apth]
        + abs(x3r-x4l)*(unitvector (point (length apth) of apth -
            point 0 of apth) rotated 90),
        z4r,
        0.5[point 0 of apth, point (length apth) of apth]
        + abs(x3r-x4r)*(unitvector (point (length apth) of apth -
            point 0 of apth) rotated 90),
        z3r,
        point 0 of apth);
    else:
      s := solve f(0,length apth);
      T := mapto(z4l,
        point s of apth + (w-2.5u#+0.5min_breadth+0.5max_breadth)
        *(unitvector (direction s of apth) rotated 90),
        z4r,
        point s of apth + (w-2.5u#+0.5min_breadth-0.5max_breadth)
        *(unitvector (direction s of apth) rotated 90),
        z3r,
        point 0 of apth);
    fi;

    bottom_part(T);

    %  The top part of the parenthesis

    save top_part;
    vardef top_part(expr T) =
      filldraw  (z1l{3(x2l-x1l),y2-y1}..{down}z2l
        --reverse(z1r{3(x2r-x1r),y2-y1}..{down}z2r)
        --cycle) transformed T text_;
    enddef;

    save g;
    vardef g(expr t) =
      abs(point (length apth) of apth - (point t of apth +
          (w-2.5u#+0.5min_breadth+0.5max_breadth)
          *(unitvector (direction s of apth) rotated 90)))
      < ((h+d) ++ (w-2.5u#+0.5min_breadth+0.5max_breadth))
    enddef;

    save t;  numeric t;
    transform T;  % transform the top part
    if arclength apth = 0:
      T := identity shifted (point (length apth) of apth - z1r);
    elseif arclength apth < y1-y2+y4-y3:
      T := mapto(z2l,
        0.5[point 0 of apth, point (length apth) of apth]
        +abs(x1r-x2l)*(unitvector (point (length apth) of apth
            - point 0 of apth) rotated 90),
        z2r,
        0.5[point 0 of apth, point (length apth) of apth]
        +abs(x1r-x2r)*(unitvector (point (length apth) of apth
            - point 0 of apth) rotated 90),
        z1r,
        point (length apth) of apth);
    else:
      t := solve g(length apth, 0);
      T := mapto(z2l,
        point t of apth + (w-2.5u#+0.5min_breadth+0.5max_breadth)
        *(unitvector (direction t of apth) rotated 90),
        z2r,
        point t of apth + (w-2.5u#+0.5min_breadth-0.5max_breadth)
        *(unitvector (direction t of apth) rotated 90),
        z1r,
        point (length apth) of apth);
    fi;

    top_part(T);

    %  The extension part
    
    save extension_part;  
    vardef extension_part(expr ss,tt) =
      numeric    stp; stp:=(ss-tt) div 5pt;
                      if stp=0: stp:=1; fi
                      stp:=(ss-tt)/stp;
  
      pickup pencircle scaled heavy_rule_thickness#;
  
      if stp>0:
      draw for uu=ss step stp until tt-stp:
        point uu of apth + (w-2.5u#+.5min_breadth)
                             *(unitvector (direction uu of apth) rotated 90)
        {direction uu of apth} ..
      endfor
      {direction tt of apth}
      point tt of apth + (w-2.5u#+.5min_breadth)
                         *(unitvector (direction tt of apth) rotated 90) text_;
      fi
    enddef;
  
    if arclength apth > y1-y2+y4-y3:
      extension_part(s,t);
    fi

    pickup prevpen;
    
  enddef;
  
enddef;
    