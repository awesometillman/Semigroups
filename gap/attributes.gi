#############################################################################
##
#W  attributes.gi
#Y  Copyright (C) 2013                                   James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# Note about the difference between One and MultiplicativeNeutralElement 
# (the same goes for Zero and MultplicativeZero):
#
# One(s) returns One(Representative(s)) if it belongs to s, so that 
# One(s)=Transformation([1..DegreeOfTransformationSemigroup(s)]) if s is a
# transformation semigroup and it returns fail otherwise, or it returns 
# PartialPerm([1..DegreeOfPartialPermSemigroup]) if this belongs to s. 
#
# MultiplicativeNeutralElement on the other hand returns the element of s that
# acts as the identity, note that this can be equal to One(s) but it can also
# not be equal t One(s). 
#
# A semigroup satisfies IsMonoidAsSemigroup(s) if
# MultiplicativeNeutralElement(x)<>fail, so it could be that One(s) returns
# fail but IsMonoidAsSemigroup is still true. 

# Note that a semigroup satisfies IsTransformationMonoid only if One(s)<>fail. 

# JDM this should be undocumented until fixed

InstallMethod(EmbeddingNC, "for a perm group and an acting semigroup",
[IsPermGroup, IsActingSemigroup],
function(g, s)
  local convert, creator, one, t, emb, conj;
 
  if IsTransformationSemigroup(s) then 
    convert:=x-> AsTransformation(x, DegreeOfTransformationSemigroup(s));
  elif IsPartialPermSemigroup(s) then 
    convert:=x-> AsPartialPerm(x, DomainOfPartialPermCollection(s));
    # JDM this won't work in general if Points(s) is not the correct set to act
    # on.
  fi;

  if IsMonoid(s) then 
    creator:=Monoid;
  else
    creator:=Semigroup;
  fi;

  if NrMovedPoints(g)<=ActionDegree(s) then 
    conj:=MappingPermListList(MovedPoints(g), [1..NrMovedPoints(g)]);
    emb:=x-> convert(x^conj);
    t:=creator(List(GeneratorsOfGroup(g), emb));
  else
    Error("the number of moved points of the group is greater than the ",
    "degree of the semigroup");
    return;
  fi;

  return MappingByFunction(g, t, emb, AsPermutation); 
end);

#

InstallMethod(GroupOfUnits, 
"for an acting semigroup with generators",
[IsActingSemigroup and HasGeneratorsOfSemigroup],
function(s)
  local r, m, g, emb, u;

  if MultiplicativeNeutralElement(s)=fail then
    return fail;
  fi;

  r:=GreensRClassOfElementNC(s, MultiplicativeNeutralElement(s));
  g:=SchutzenbergerGroup(r);
  #Group(AsPermutation(Random(r)));

  #while Size(g)<Size(r) do
  # g:=ClosureGroup(g, AsPermutation(Random(r)));
  #od;
  
  emb:=EmbeddingNC(g, s);
  u:=Range(emb);
  SetIsomorphismPermGroup(u, InverseGeneralMapping(emb));
  SetIsGroupAsSemigroup(u, true);
  UseIsomorphismRelation(u, g);

  return u;
end);

#

InstallMethod(IdempotentGeneratedSubsemigroup, 
"for an acting semigroup with generators",
[IsActingSemigroup and HasGeneratorsOfSemigroup],
s-> Semigroup(Idempotents(s), rec(small:=true)));

#

InstallMethod(InjectionPrincipalFactor, "for a D-class of an acting semigroup",
[IsGreensDClass and IsActingSemigroupGreensClass],
function(d)
  local g, rep, rreps, lreps, mat, inj, zero, bound_r, bound_l, inv_l, inv_r,
  f, rms, iso, inv, hom, i, j;

  if not IsRegularDClass(d) then
    Error("not yet implemented,");
    return;
  elif NrIdempotents(d)=NrHClasses(d) then
    return IsomorphismReesMatrixSemigroup(d);
  fi;

  g:=GroupHClass(d);
  rep:=Representative(g);
  g:=Range(IsomorphismPermGroup(g));

  rreps:=HClassReps(LClass(d, rep));
  lreps:=HClassReps(RClass(d, rep));
  mat:=[];

  inj:=InjectionZeroMagma(g);
  SetIsTotal(inj, true);
  SetIsSingleValued(inj, true);
  g:=Range(inj);
  zero:=MultiplicativeZero(g);
  bound_r:=BlistList([1..Length(rreps)], []);
  bound_l:=BlistList([1..Length(lreps)], []);
  inv_l:=EmptyPlist(Length(lreps));
  inv_r:=EmptyPlist(Length(rreps));

  for i in [1..Length(lreps)] do
    mat[i]:=[];
    for j in [1..Length(rreps)] do
      f:=lreps[i]*rreps[j];
      if f in d then
        mat[i][j]:=AsPermutation(f);
        if not bound_r[j] then
          bound_r[j]:=true;
          inv_r[j]:=mat[i][j]^-1*lreps[i];
        fi;
        if not bound_l[i] then
          bound_l[i]:=true;
        inv_l[i]:=rreps[j]*mat[i][j]^-1;
        fi;
        mat[i][j]:=mat[i][j]^inj;
      else
        mat[i][j]:=zero;
      fi;
    od;
  od;

  rms:=ReesZeroMatrixSemigroup(g, mat);
  iso:=function(f)
    local o, i, j;
    o:=LambdaOrb(d);
    i:=Position(o, LambdaFunc(Parent(d))(f));

    if i=fail then
      return fail;
    fi;
    i:=Position(OrbSCC(o)[OrbSCCLookup(o)[i]], i);
    if not IsInverseOpClass(d) then 
      o:=RhoOrb(d);
    fi;
    j:=Position(o, RhoFunc(Parent(d))(f));
    if j=fail then
      return fail;
    fi;
    j:=Position(OrbSCC(o)[OrbSCCLookup(o)[j]], j);

    return RMSElementNC(rms, j,
      AsPermutation(inv_r[j]*f*inv_l[i])^inj, i);
  end;

  inv:=function(x)
    local i, a, j;
    i:=RowOfRMSElement(x);
    a:=Images(InverseGeneralMapping(inj), UnderlyingElementOfRMSElement(x))[1];
    j:=ColumnOfRMSElement(x);
    return rreps[i]*a*lreps[j];
  end;

  hom:=MappingByFunction(d, rms, iso, inv);
  SetIsInjective(hom, true);
  SetIsTotal(hom, true);

  return hom;
end);

#

InstallMethod(IrredundantGeneratingSubset,
"for an associative element with action collection",
[IsAssociativeElementWithActionCollection],
function(coll)
  local gens, j, out, i, redund, f;
  
  if IsSemigroup(coll) and HasGeneratorsOfSemigroup(coll) then
    coll:=ShallowCopy(GeneratorsOfSemigroup(coll));
  fi;
  
  gens:=Set(ShallowCopy(coll)); j:=Length(gens);
  coll:=Permuted(coll, Random(SymmetricGroup(Length(coll))));
  Sort(coll, function(x, y) return ActionRank(x)>ActionRank(y); end);
 
  out:=EmptyPlist(Length(coll));
  redund:=EmptyPlist(Length(coll));
  i:=0;

  repeat
    i:=i+1; f:=coll[i];
    if InfoLevel(InfoSemigroups)>=3 then 
      Print("at \t", i, " of \t", Length(coll), " with \t", Length(redund),
      " redundant, \t", Length(out), " non-redundant\r");
    fi;

    if not f in redund and not f in out then
      if f in Semigroup(Difference(gens, [f])) then
        AddSet(redund, f); gens:=Difference(gens, [f]);
      else
        AddSet(out, f);
      fi;
    fi;
  until Length(redund)+Length(out)=j;

  if InfoLevel(InfoSemigroups)>1 then
    Print("\n");
  fi;
  return out;
end);

#

InstallMethod(IsomorphismReesMatrixSemigroup, 
"for a simple semigroup with generators",
[IsSimpleSemigroup and HasGeneratorsOfSemigroup],
function(s)
  return IsomorphismReesMatrixSemigroup(DClass(s, Representative(s)));
end);


#

InstallMethod(IsomorphismReesMatrixSemigroup, 
"for D-class of an acting semigroup",
[IsGreensDClass and IsActingSemigroupGreensClass],
function(d)
  local g, rep, rreps, lreps, mat, rms, iso, inv, hom, i, j;

  if not IsRegularDClass(d) or not NrIdempotents(d)=NrHClasses(d) then
    Error("every H-class of the D-class should be a group,",
    " try InjectionPrincipalFactor instead,");
    return;
  fi;

  g:=GroupHClass(d);

  rep:=Representative(g); 
  g:=Range(IsomorphismPermGroup(g));

  rreps:=HClassReps(LClass(d, rep)); 
  lreps:=HClassReps(RClass(d, rep));
  mat:=[];
  
  for i in [1..Length(lreps)] do 
    mat[i]:=[];
    for j in [1..Length(rreps)] do 
      mat[i][j]:=AsPermutation(lreps[i]*rreps[j]);
    od;
  od;

  rms:=ReesMatrixSemigroup(g, mat);
  
  iso:=function(f)
    local o, i, j;
    o:=LambdaOrb(d);
    i:=Position(o, LambdaFunc(Parent(d))(f));
    if i=fail then 
      return fail;
    fi;
    i:=Position(OrbSCC(o)[OrbSCCLookup(o)[i]], i);
    if not IsInverseOpClass(d) then 
      o:=RhoOrb(d);
    fi;
    j:=Position(o, RhoFunc(Parent(d))(f)); 
    if j=fail then 
      return fail;
    fi;
    j:=Position(OrbSCC(o)[OrbSCCLookup(o)[j]], j);

    return RMSElementNC(rms, j,
      AsPermutation(rreps[j])^-1*AsPermutation(f)*
      AsPermutation(lreps[i])^-1, i);
  end;

  inv:=function(x)
    local i, a, j;
    i:=RowOfReesMatrixSemigroupElement(x);
    a:=UnderlyingElementOfReesMatrixSemigroupElement(x);
    j:=ColumnOfReesMatrixSemigroupElement(x);
    return rreps[i]*a*lreps[j];
  end;

  hom:=MappingByFunction(d, rms, iso, inv);
  SetIsInjective(hom, true);
  SetIsTotal(hom, true);

  return hom;
end);

#

InstallMethod(InversesOfSemigroupElement, 
"for acting semigroup with generators and associative element",
[IsActingSemigroup and HasGeneratorsOfSemigroup, IsAssociativeElement],
function(s, f)

  if f in s then
    return InversesOfSemigroupElementNC(s, f);
  fi;

  return fail;
end);

#JDM check this works...

InstallMethod(InversesOfSemigroupElementNC, 
"for an acting semigroup and acting elt",
[IsActingSemigroup and HasGeneratorsOfSemigroup, IsAssociativeElement],
function(s, f)
  local regular, lambda, rank, rhorank, tester, j, o, rhos, opts, grades, rho_f, lambdarank, creator, inv, out, k, g, rho, name, i, x;

  regular:=IsRegularSemigroup(s);

  if not (regular or IsRegularSemigroupElementNC(s, f)) then
    return [];
  fi;

  lambda:=LambdaFunc(s)(f);
  rank:=ActionRank(f); 
  rhorank:=RhoRank(s);
  tester:=IdempotentTester(s);
  j:=0;

  # can't use GradedRhoOrb here since there may be inverses not D-related to f
  # JDM is this really true?
  if HasRhoOrb(s) and IsClosed(RhoOrb(s)) then 
    o:=RhoOrb(s);
    rhos:=EmptyPlist(Length(o));
    for rho in o do
      if rhorank(rho)=rank and tester(lambda, rho) then
        j:=j+1;
        rhos[j]:=rho;
      fi;
    od;
  else
      
    opts:=rec(  treehashsize:=s!.opts.hashlen.M, 
                gradingfunc:=function(o, x) return rhorank(x); end,
                onlygrades:=function(x, y) return x>=rank; end,
                onlygradesdata:=fail );
    
    for name in RecNames(LambdaOrbOpts(s)) do
      opts.(name):=LambdaOrbOpts(s).(name);
    od;

    o:=Orb(s, RhoOrbSeed(s), RhoAct(s), opts);
    Enumerate(o, infinity);
    
    grades:=Grades(o);
    rhos:=EmptyPlist(Length(o));
    for i in [2..Length(o)] do 
      if grades[i]=rank and tester(lambda, o[i]) then 
        j:=j+1;
        rhos[j]:=o[i];
      fi;
    od;
  fi;
  ShrinkAllocationPlist(rhos);
  
  rho_f:=RhoFunc(s)(f);
  lambdarank:=LambdaRank(s);
  creator:=IdempotentCreator(s);
  inv:=LambdaInverse(s);
  
  out:=[]; k:=0; 
 
  if HasLambdaOrb(s) and IsClosed(LambdaOrb(s)) then 
    o:=LambdaOrb(s);
    for i in [2..Length(o)] do
      if lambdarank(o[i])=rank and tester(o[i], rho_f) then
        for rho in rhos do
          g:=creator(lambda, rho)*inv(o[i], f);
          if regular or g in s then
            k:=k+1; 
            out[k]:=g;
          fi;
        od;
      fi;
    od;
  else
     opts:=rec(  treehashsize:=s!.opts.hashlen.M, 
                gradingfunc:=function(o, x) return lambdarank(x); end,
                onlygrades:=function(x, y) return x>=rank; end,
                onlygradesdata:=fail ); #shouldn't this be fail
    
    for name in RecNames(LambdaOrbOpts(s)) do
      opts.(name):=LambdaOrbOpts(s).(name);
    od;

    o:=Orb(s, LambdaOrbSeed(s), LambdaAct(s), opts);
    Enumerate(o);
    grades:=Grades(o);
    
    for i in [2..Length(o)] do 
      if grades[i]=rank and tester(o[i], rho_f) then
        for rho in rhos do
          g:=creator(lambda, rho)*inv(o[i], f);
          if regular or g in s then
            k:=k+1; 
            out[k]:=g;
          fi;
        od;
      fi;
    od;
  fi; 
 
  return out;
end);

#

InstallMethod(MultiplicativeNeutralElement, "for an acting semigroup",
[IsActingSemigroup and HasGeneratorsOfSemigroup],
function(s)
  local gens, n, rank, lambda, f, r;

  gens:=Generators(s);
  n:=Maximum(List(gens, ActionRank));

  if n=ActionDegree(s) then
    return One(s);
  fi;

  rank:=LambdaRank(s);
  lambda:=LambdaFunc(s);
  f:=First(gens, f-> rank(lambda(f))=n);

  r:=GreensRClassOfElementNC(s, f); #NC? JDM 

  if not NrIdempotents(r)=1 then
    Info(InfoSemigroups, 2, "the number of idempotents in the R-class of the",
    " first maximum rank");
    Info(InfoSemigroups, 2, " generator is not 1");
    return fail;
  fi;

  f:=Idempotents(r)[1];

  if ForAll(gens, x-> x*f=x and f*x=x) then
    return f;
  fi;

  Info(InfoSemigroups, 2, "the unique idempotent in the R-class of the first",
  " maximum rank");
  Info(InfoSemigroups, 2, " generator is not the identity");
  return fail;
end);

# it just so happens that the MultiplicativeNeutralElement of a semigroup of
# partial permutations has to coincide with the One. This is not the case for
# transformation semigroups

InstallMethod(MultiplicativeNeutralElement, "for a partial perm semi",
[IsPartialPermSemigroup], One);

#

InstallMethod(MultiplicativeZero, "for an acting semigroup",
[IsActingSemigroup and HasGeneratorsOfSemigroup],
function(s)
  local min, o, rank, i, pos, f, m, rank_i, min_found, n;
  
  min:=MinActionRank(s);
  o:=LambdaOrb(s);
  rank:=LambdaRank(s);
  
  #is there an element in s with minimum possible rank
  if IsTransformationSemigroup(s) then 
    i:=0;
    repeat 
      i:=i+1;
      pos:=EnumeratePosition(o, [i], false);
    until pos<>fail or i=ActionDegree(s);
  elif IsPartialPermSemigroup(s) then 
    pos:=EnumeratePosition(o, [], false);
  else
    pos:=LookForInOrb(o, function(o, x) return rank(x)=min; end, 2);
  fi;
  if pos<>fail then
    f:=EvaluateWord(GeneratorsOfSemigroup(s), 
     TraceSchreierTreeForward(o, pos));
  fi;

  # lambda orb is closed, find an element with minimum rank
  if not IsBound(f) then 
    min_found:=rank(o[2]); pos:=2; i:=1; 
    
    while min_found>min and i<Length(o) do 
      i:=i+1;
      rank_i:=rank(o[i]);
      if rank_i<min_found then 
        min_found:=rank_i;
        pos:=i;
      fi;
    od;
    f:=EvaluateWord(GeneratorsOfSemigroup(s), TraceSchreierTreeForward(o, pos));
  fi;

  if IsIdempotent(f) and Size(GreensRClassOfElementNC(s, f))=1 then
    return f;
  fi;

  return fail;
end);

#JDM better if this returned an actual semigroup ideal!!

InstallMethod(MinimalIdeal, "for an acting semigroup with generators", 
[IsActingSemigroup and HasGeneratorsOfSemigroup],
function(s)
  local rank, o, pos, min, len, m, f, i, n;

  rank:=LambdaRank(s);
  o:=LambdaOrb(s);
  
  pos:=LookForInOrb(LambdaOrb(s), 
   function(o, x) return rank(x)=MinActionRank(s); end, 2);

  if pos=false then 
    min:=rank(o[2]); pos:=2; len:=Length(o);

    for i in [3..len] do 
      m:=rank(o[i]);
      if m<min then
        pos:=i; min:=m;
      fi;
    od;
  fi;

  f:=EvaluateWord(o!.gens, TraceSchreierTreeForward(o, pos));
  i:=Semigroup(Elements(GreensDClassOfElementNC(s, f)), rec(small:=true));

  SetIsSimpleSemigroup(i, true);
  return i; 
end);

#JDM should be redone for inverse acting semigroups

InstallMethod(MinimalIdeal, "for a partial perm semi",
[IsPartialPermSemigroup],
function(s)
  local n, gens, max, bound, o, i, f, I;

  n:=ActionDegree(s);
  gens:=Generators(s);
  max:=Maximum(List(gens, ActionDegree));

  if max=n then
    bound:=2^n;
  else
    bound:=Sum([1..max], x-> Binomial(n, x));
  fi;

  o:=Orb(gens, DomainOfPartialPermCollection(s), OnSets, 
    rec( schreier:=true,
         gradingfunc:=function(o, x) return Length(x); end,
         onlygrades:=[0..max],
         lookingfor:=function(o, x) return Length(x)=0; end));
  
  Enumerate(o, bound);

  if IsPosInt(PositionOfFound(o)) then
    i:=PositionOfFound(o);
  else
    i:=Position(Grades(o), Minimum(Grades(o)));
  fi;

  f:=EvaluateWord(gens, TraceSchreierTreeForward(o, i));
  I:=InverseSemigroup(Elements(GreensDClassOfElementNC(s, f)));
  SetIsGroupAsSemigroup(I, true);
  return I;
end);

#

InstallMethod(PrimitiveIdempotents, 
"for an acting semigroup with inverse op and generators",
[IsActingSemigroupWithInverseOp and HasGeneratorsOfSemigroup],
function(s)
  local r;
  
  if MultiplicativeZero(s)=fail then 
    r:=Set(List(OrbSCC(LambdaOrb(s)), 
     x-> LambdaRank(s)(LambdaOrb(s)[x[1]])))[1];
  else
    r:=Set(List(OrbSCC(LambdaOrb(s)), 
     x-> LambdaRank(s)(LambdaOrb(s)[x[1]])))[2];
  fi;

  return Idempotents(s, r);
end);

#

InstallMethod(PrincipalFactor, "for a D-class", 
[IsGreensDClass], 
d-> Range(InjectionPrincipalFactor(d)));

#

InstallMethod(SmallGeneratingSet, 
"for an acting semigroup with generators", 
[IsActingSemigroup and HasGeneratorsOfSemigroup],
s -> Generators(Semigroup(Generators(s), rec(small:=true))));

#

InstallMethod(SmallGeneratingSet, 
"for an acting semigroup with inverse op and generators", 
[IsActingSemigroupWithInverseOp and HasGeneratorsOfSemigroup],
s -> Generators(InverseSemigroup(Generators(s), rec(small:=true))));

#

InstallMethod(StructureDescription, "for an acting Brandt semigroup",
[IsActingSemigroup and IsBrandtSemigroup],
function(s)
  local x, d;
  
  x:=First(Generators(s), x-> x<>MultiplicativeZero(s));
  d:=GreensDClassOfElementNC(s, x);
  
  return Concatenation("B(", StructureDescription(GroupHClass(d)), ", ",
  String(NrRClasses(d)), ")");
end);

#

InstallMethod(StructureDescription, 
"for an acting group as semigroup",
[IsActingSemigroup and IsGroupAsSemigroup],
s-> StructureDescription(Range(IsomorphismPermGroup(s))));

# some things to move...

# JDM expand so that this is really an isomorphism and that the range knows some
# of the properties that the domain does. 
# Also move this to partition.g*

#InstallMethod(IsomorphismBipartitionSemigroup, 
#"for a transformation semigroup with generators",
#[IsTransformationSemigroup and HasGeneratorsOfSemigroup],
#function(s)
  
#  return MappingByFunction(s, Semigroup(List(GeneratorsOfSemigroup(s),     
#   AsBipartition)), AsBipartition, AsTransformation);
#end);

#

InstallMethod(IsomorphismTransformationMonoid, "for a transformation semigroup",
[IsActingSemigroup and HasGeneratorsOfSemigroup],
function(s)

  if not IsMonoidAsSemigroup(s) then 
    Error( "Usage: the argument must be a transformation semigroup ",
    "satisfying IsMonoidAsSemigroup," );
    return;
  fi;

  return MappingByFunction(s, Monoid(Difference(Generators(s),
  [TransformationNC([1..DegreeOfTransformationSemigroup(s)])])), x-> x, x-> x);
end);

#

InstallMethod(IsomorphismPermGroup, "for a transformation semigroup", 
[IsTransformationSemigroup and HasGeneratorsOfSemigroup],
function(s)
 
   if not IsGroupAsSemigroup(s)  then
     Error( "Usage: trans. semigroup satisfying IsGroupAsSemigroup,");
     return; 
   fi;
 
   return MappingByFunction(s, Group(List(Generators(s), AsPermutation)), 
    AsPermutation, x-> AsTransformation(x, ActionDegree(s)));
end);

#EOF
