%% cmarrows.mp
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

if known cmarrows_fileversion: endinput fi;
string cmarrows_fileversion;
cmarrows_fileversion := "2006/12/18, v0.9";
message "Loading cmarrows " & cmarrows_fileversion;

vardef setup_cmarrows(text argument_list) =

  save sfile;
  string sfile;

  save arrow_name, brace_name, parameter_file, macro_name;
  string arrow_name, brace_name, parameter_file, macro_name;
  
  argument_list;
  
  if not known arrow_name:
    arrow_name := brace_name;
  fi  
  
  if     arrow_name="Bigbrace"           : sfile = "tgbx0001.mp";
  elseif arrow_name="Biggbrace"          : sfile = "tgbx0002.mp";
  elseif arrow_name="bigbrace"           : sfile = "tgbx0003.mp";
  elseif arrow_name="biggbrace"          : sfile = "tgbx0004.mp";
  elseif arrow_name="extensiblebrace"    : sfile = "tgbx0005.mp";
  elseif arrow_name="parallelarrows"     : sfile = "tgbx0006.mp";
  elseif arrow_name="twoheadarrow"       : sfile = "tgbx0007.mp";
  elseif arrow_name="twowayoldarrow"     : sfile = "sgbx0008.mp";
  elseif arrow_name="paralleloppositearrows": sfile = "rgbx0009.mp";
  elseif arrow_name="twowayarrow"        : sfile = "sgbx0010.mp";
  elseif arrow_name="twowaydoublearrow"  : sfile = "sgbx0011.mp";
  elseif arrow_name="hookleftarrow"      : sfile = "sgbx0012.mp";
  elseif arrow_name="hookrightarrow"     : sfile = "sgbx0013.mp";
  elseif arrow_name="doublearrow"        : sfile = "sgbx0014.mp";
  elseif arrow_name="lefthalfarrow"      : sfile = "sgbx0015.mp";
  elseif arrow_name="paralleloppositerighthalfarrows": sfile = "rgbx0016.mp";
  elseif arrow_name="mapstoarrow"        : sfile = "sgbx0017.mp";
  elseif arrow_name="oldtexarrow"        : sfile = "sgbx0018.mp";
  elseif arrow_name="righthalfarrow"     : sfile = "sgbx0019.mp";
  elseif arrow_name="paralleloppositelefthalfarrows" : sfile = "rgbx0020.mp";
  elseif arrow_name="shortaxisarrow"     : sfile = "sgbx0021.mp";
  elseif arrow_name="texarrow"           : sfile = "sgbx0022.mp";
  elseif arrow_name="tailarrow"          : sfile = "sgbx0023.mp";
  elseif arrow_name="tripplearrow"       : sfile = "sgbx0024.mp";
  elseif arrow_name="paralleloppositerightarrows": sfile = "rgbx0025.mp";
  elseif arrow_name="paren"              : sfile = "tgbx0027.mp";
  else                                   : errmessage "unknown options";
  fi

  expandafter save scantokens ("setup_" & arrow_name);

  scantokens ("input " & sfile);

  scantokens ("setup_" & arrow_name & "(" & 
      ditto & parameter_file & ditto & "," &
      ditto & macro_name & ditto & ");" );

enddef;
