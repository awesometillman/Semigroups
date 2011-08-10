#############################################################################
##
#W  properties.gi
#Y  Copyright (C) 2011                                   James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# Ecom (commuting idempotents), LI (locally trivial), 
# LG (locally group), B1 (dot-depth one), DA (regular D-classes are idempotent)
# R v L (???), IsNilpotentSemigroup, inverses, local submonoid, right ideal, 
# left ideal, kernel!?

# IsMonogenicSemigroup, IsRightSimple, IsLeftSimple, IsLeftCancellative, 
# IsRightCancellative, IsRightGroup, IsLeftGroup, IsUnitarySemigroup, 
# IsRightUnitarySemigp, IsLeftUnitarySemigp, IsCongruenceFree,
# PrimitiveIdempotents, IdempotentOrder, IsZeroRectangularBand
# IsLeftNormalBand, IsRightNormalBand, IsNormalBand, IsEUnitarySemigroup
# IsRectangularGroup, IsBandOfGroups, IsFreeBand, IsFreeSemilattice,
# IsFreeNormalBand, IsBrandtSemigroup, IsFundamentalInverseSemigp, 
# IsFullSubsemigroup (of an inverse semigroup), IsFactorizableInverseMonoid,
# IsFInverseSemigroup, IsSemigroupWithCentralIdempotents, IsLeftUnipotent,
# IsRightUnipotent, IsSemigroupWithClosedIdempotents.

#GGG

# new for 0.1! - GroupOfUnits - "for a tranformation semigroup"
###########################################################################
# Notes: returns a permutation group isomorphic to the group of units of the
# input semigroup. 

InstallMethod(GroupOfUnits, "for a tranformation semigroup", 
[IsTransformationSemigroup and HasGeneratorsOfSemigroup], 
function(s)
  local h, m, g;

  if not IsMonoidAsSemigroup(s) then 
    return fail;
  fi;

  h:=GreensHClassOfElement(s, MultiplicativeNeutralElement(s));
  m:=Size(h); g:=Group(());

  repeat 
    g:=ClosureGroup(g, AsPermutation(Random(h)));
  until Size(g)=m;

  return g;
end);

#III

# new for 0.1! - IrredundantGeneratingSubset - "for a tranformation coll."
###########################################################################
# Notes: this does not work all that well, use SmallGeneratingSet first. 

InstallMethod(IrredundantGeneratingSubset, "for a transformation collection", 
[IsTransformationCollection],
function(coll)
  local gens, out, i, redund, f;
  
  if IsTransformationSemigroup(coll) then 
    coll:=ShallowCopy(Generators(coll));
  fi;
  
  gens:=Set(ShallowCopy(coll));
  coll:=Permuted(coll, Random(SymmetricGroup(Length(coll))));
  Sort(coll, function(x, y) return Rank(x)>Rank(y); end);
  
  out:=EmptyPlist(Length(coll));
  redund:=EmptyPlist(Length(coll));
  i:=0;

  repeat 
    i:=i+1; f:=coll[i];
    if InfoLevel(InfoCitrusProperties)>1 then 
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
  until Length(redund)+Length(out)=Length(coll);

  if InfoLevel(InfoCitrusProperties)>1 then 
    Print("\n");
  fi;
  return out;
end);

#IIIBBB

# mod for 0.1! - IsBand - "for a transformation semigroup"
###########################################################################
#JDM must find some reasonable examples to test this on!
# this could maybe be better!

InstallMethod(IsBand, "for a transformation semigroup", 
[IsTransformationSemigroup and HasGeneratorsOfSemigroup], s-> 
 IsCompletelyRegularSemigroup(s) and IsGreensHTrivial(s));

# new for 0.1! - IsBlockGroup - "for a transformation semigroup"
#############################################################################
# JDM check we didn't have a better version of this previously!

InstallMethod(IsBlockGroup, "for a transformation semigroup",
[IsTransformationSemigroup and HasGeneratorsOfSemigroup], 
function(s)
  local iter, i, f, o, scc, reg, d;

  if HasIsInverseSemigroup(s) and IsInverseSemigroup(s) then 
    return true;
  elif (HasIsRegularSemigroup(s) and IsRegularSemigroup(s)) and
   (HasIsInverseSemigroup(s) and not IsInverseSemigroup(s)) then 
    return false;
  fi;

  iter:=IteratorOfDClassRepsData(s); 
    
  for d in iter do
    i:=NrIdempotentsRClassFromData(s, d[1]);
    if i>1 then #this could be better
    # we only need to find 2 transversals to return false.
      return false;
    fi;
    
    #now check that D-classes are square...
    f:=AsSet(DClassRepFromData(s, d)![1]);
    o:=KernelOrbitFromData(s, d);
    scc:=KernelOrbitSCCFromData(s, d[2]);
    reg:=false;
    for i in scc do 
      if IsInjectiveTransOnList(o[i], f) then 
        if reg then 
          return false;
        fi;
        reg:=true;
      fi;
    od;
  od;

  return true;
end);

#IIICCC

# new for 0.1! - IsCliffordSemigroup - "for a transformation semigroup"
###########################################################################

InstallMethod(IsCliffordSemigroup, "for a transformation semigroup", 
[IsTransformationSemigroup and HasGeneratorsOfSemigroup], 
function(s)
  local gens, idem, f, g;

  if HasIsInverseSemigroup(s) and not IsInverseSemigroup(s) then 
    return false;
  elif not IsCompletelyRegularSemigroup(s) then 
    return false;
  elif IsGroupAsSemigroup(s) then
    return true;
  fi;

  if not IsRegularSemigroup(s) then 
    return false;
  fi;

  gens:=Generators(s);

  idem:=List(gens, x->IdempotentNC(CanonicalTransSameKernel(x), 
   ImageSetOfTransformation(x)));

  for f in gens do
    for g in idem do
      if not f*g=g*f then 
        return false;
      fi;
    od;
  od;

  SetIsInverseSemigroup(s, true);
  SetIsBlockGroup(s, true);

  return true;
end);

# new for 0.1! - IsCommutativeSemigroup - "for a transformation semigroup"
###########################################################################

InstallMethod(IsCommutativeSemigroup, "for a transformation semigroup",
[IsTransformationSemigroup and HasGeneratorsOfSemigroup],
function(s)
  local gens, n, i, j; 

  gens:=Generators(s);
  n:=Length(gens);

  for i in [1..n] do
    for j in [i+1..n] do
      if not gens[i]*gens[j]=gens[j]*gens[i] then 
        return false;
      fi;
    od;
  od;

  return true;
end);

# new for 0.1! - IsCompletelyRegularSemigroup - "for a trans. semigp."
###########################################################################

InstallMethod(IsCompletelyRegularSemigroup, "for a transformation semigroup", 
[IsTransformationSemigroup and HasGeneratorsOfSemigroup],
function(s)
  local gens, o, f;

  if HasIsRegularSemigroup(s) and not IsRegularSemigroup(s) then 
    return false;
  fi;

  gens:=Generators(s);

  for f in gens do
    o:=Orb(gens, ImageSetOfTransformation(f), OnSets, 
     rec(lookingfor:=function(o, x) 
     return not IsInjectiveTransOnList(f, x); end));
    Enumerate(o);
    if not PositionOfFound(o)=false then 
      return false;
    fi;
  od;

  return true;
end);

# new for 0.1! - IsCompletelySimpleSemigroup - "for a trans. semigroup"
###########################################################################
# Notes: this test required to avoid conflict with Smallsemi, DeclareSynonymAttr
# causes problems. 

InstallMethod(IsCompletelySimpleSemigroup, "for a trans. semi.",
[IsTransformationSemigroup and HasGeneratorsOfSemigroup], 
 x-> IsSimpleSemigroup(x) and IsFinite(x));

InstallTrueMethod(IsCompletelySimpleSemigroup, IsSimpleSemigroup and IsFinite);

#IIIGGG

# new for 0.1! - IsGreensHTrivial - "for a transformation semigroup"
###########################################################################

InstallOtherMethod(IsGreensHTrivial, "for a transformation semigroup", 
[IsTransformationSemigroup and HasGeneratorsOfSemigroup], 
function(s)
  local iter, g;

  iter:=IteratorOfDClassRepsData(s);
  
  repeat 
    g:=DClassSchutzGpFromData(s, NextIterator(iter)[2]);
    if Size(g)>1 then 
      return false;
    fi;
  until IsDoneIterator(iter);
  return true;
end);

# new for 0.1! - IsGreensHTrivial - "for a D-class of a trans. semigp"
###########################################################################

InstallOtherMethod(IsGreensHTrivial, "for a D-class of a trans. semigp", 
[IsGreensDClass and IsGreensClassOfTransSemigp], 
  d-> NrGreensHClasses(d)=Size(d));

# new for 0.1! - IsGreensLTrivial - "for a transformation semigroup"
#############################################################################

InstallMethod(IsGreensLTrivial, "for a transformation semigroup",
[IsTransformationSemigroup and HasGeneratorsOfSemigroup],
function(s)
  local iter, d;

  iter:=IteratorOfDClassRepsData(s); 
  
  #JDM here it would be useful to pass OrbitsOfKernels(s)!.orbits to 
  # KernelOrbitSchutzGpFromData...

  for d in iter do 
    if not (Size(KernelOrbitSchutzGpFromData(s, d[2]))=1 and 
     Length(KernelOrbitSCCFromData(s, d[2]))=1) then
      return false;
    fi;
  od;

  return true;
end);

# new for 0.1! - IsGreensLTrivial - "for a D-class of a trans. semigp"
#############################################################################

InstallOtherMethod(IsGreensLTrivial, "for a D-class of a trans. semigp", 
[IsGreensDClass and IsGreensClassOfTransSemigp], 
  d-> NrGreensLClasses(d)=Size(d));

# new for 0.1! - IsGreensRTrivial - "for a transformation semigroup"
#############################################################################

InstallMethod(IsGreensRTrivial, "for a transformation semigroup",
[IsTransformationSemigroup and HasGeneratorsOfSemigroup],
function(s)
  local iter, r, d;

  if OrbitsOfKernels(s)!.finished then 
    iter:=IteratorOfGreensDClasses(s);
    for d in iter do 
      if not (Size(ImageOrbitSchutzGpFromData(s, d!.data[1]))=1 and 
       Length(ImageOrbitFromData(s, d!.data[1]))=1) then
        return false;
      fi;
    od;
	
    return true;
  fi;

  iter:=IteratorOfRClassRepsData(s); 

  #JDM here it would be useful to pass OrbitsOfImages(s)!.orbits to 
  # RClassSchutzGpFromData...

  for d in iter do 
    if not (Size(ImageOrbitSchutzGpFromData(s, d))=1 and 
     Length(ImageOrbitFromData(s, d))=1) then 
      return false;
    fi;
  od;

  return true;
end);

# new for 0.1! - IsGreensRTrivial -  "for D-class of a trans. semigp."
#############################################################################

InstallOtherMethod(IsGreensRTrivial, "for D-class of a trans. semigp.",
[IsGreensDClass and IsGreensClassOfTransSemigp],
function(d)
  #JDM maybe better if we had an enumerator of R-classes of d...
  return NrGreensRClasses(d)=Size(d);
end);

# new for 0.1! - IsGroupAsSemigroup - "for a transformation semigroup"
###########################################################################
 
InstallMethod(IsGroupAsSemigroup, "for a transformation semigroup", 
[IsTransformationSemigroup and HasGeneratorsOfSemigroup],
function(s)
  local gens, ker, img, f;

  gens:=GeneratorsOfSemigroup(s); #not GeneratorsOfMonoid!

  if ForAll(gens, f-> RankOfTransformation(f)=
   DegreeOfTransformationSemigroup(s)) then
    return true;
  fi;

  ker:=CanonicalTransSameKernel(gens[1]);
  img:=ImageSetOfTransformation(gens[1]);

  for f in gens do 
    if not (IsInjectiveTransOnList(f, ImageSetOfTransformation(f)) and
     ImageSetOfTransformation(f)=img and 
      CanonicalTransSameKernel(f)=ker) then 
      return false;
    fi;
  od;

  return true;
end);

#IIIIII

# new for 0.1! - IsIdempotentGenerated - "for a trans semi"
###########################################################################
# Notes: should store t as IdempotentsGeneratedSubsemigroup, and should use
# ClosureSemigroup.

InstallOtherMethod(IsIdempotentGenerated, "for a transformation semigroup", 
[IsTransformationSemigroup and HasGeneratorsOfSemigroup], 
function(s) 
local gens, r, i, t;

  gens:=Generators(s);
  
  if ForAll(gens, IsIdempotent) then 
    return true;
  fi;

  if HasIsInverseSemigroup(s) and IsInverseSemigroup(s) then 
    return IsSemilatticeAsSemigroup(s);
  fi;

  r:=List(gens, Rank); 

  i:=Concatenation(List([Maximum(r),Maximum(r)-1..Minimum(r)], i-> 
   Idempotents(s, i)));
  t:=Semigroup(i);

  return ForAll(gens, f-> f in t);
end);

# new for 0.1! - IsInverseSemigroup - "for a transformation semigroup"
###########################################################################

InstallOtherMethod(IsInverseSemigroup, "for a transformation semigroup", 
[IsTransformationSemigroup and HasGeneratorsOfSemigroup],
function(s)
  local n, imgs, kers, iter, D, d;

  if HasIsRegularSemigroup(s) and not IsRegularSemigroup(s) then 
    return false;
  elif IsCompletelyRegularSemigroup(s) then
    return IsCliffordSemigroup(s);
  fi;

  n:=Degree(s); imgs:=ImagesOfTransSemigroup(s); Enumerate(imgs, 2^n);
  kers:=KernelsOfTransSemigroup(s); Enumerate(kers, Length(imgs));

  if not (IsClosed(kers) and Length(kers)=Length(imgs)) then 
    return false;
  fi;

  if OrbitsOfKernels(s)!.finished then 
    iter:=IteratorOfDClassRepsData(s); D:=true;
  else 
    iter:=IteratorOfRClassRepsData(s); D:=false;
  fi;
    
  for d in iter do
    if D then 
      d:=d[1];
    fi;
    if not NrIdempotentsRClassFromData(s, d)=1 then 
      return false;
    fi;
  od;

  return true;
end);

#IIILLL

# new for 0.1! - IsLeftZeroSemigroup - "for a transformation semigroup"
###########################################################################

InstallMethod(IsLeftZeroSemigroup, "for a transformation semigroup", 
[IsTransformationSemigroup and HasGeneratorsOfSemigroup],
function(s)
  local gens, imgs;

  gens:=Generators(s);
  imgs:=Set(List(gens, ImageSetOfTransformation));

  if Size(imgs)=1 and ForAll(gens, IsIdempotent) then
    return true;
  fi;
  return false;
end);

#IIIMMM

# new for 0.1! - IsMonoidAsSemigroup - "for a transformation semigroup"
#############################################################################

InstallOtherMethod(IsMonoidAsSemigroup, "for a transformation semigroup",
[IsTransformationSemigroup and HasGeneratorsOfSemigroup], 
 x-> not MultiplicativeNeutralElement(x)=fail);

#JDM should have methods for IsomorphismTransformationSemigroup/Monoid for 
# perm. groups. 

# new for 0.1! - IsomorphismTransformationMonoid - "for trans semi"
#############################################################################

InstallMethod(IsomorphismTransformationMonoid, "for a transformation semigroup",
[IsTransformationSemigroup and HasGeneratorsOfSemigroup],
function(s)

  if not IsMonoidAsSemigroup(s) then 
    Error( "Usage: trans. semigroup satisfying IsMonoidAsSemigroup" );
  fi;

  return MappingByFunction(s, Monoid(Difference(Generators(s),
  [TransformationNC([1..DegreeOfTransformationSemigroup(s)])])), x-> x);
end);

# new for 0.1! - IsomorphismPermGroup - "for a transformation semigroup"
#############################################################################

InstallOtherMethod(IsomorphismPermGroup, "for a transformation semigroup", 
[IsTransformationSemigroup and HasGeneratorsOfSemigroup],
function(s)

  if not IsGroupAsSemigroup(s)  then
    Error( "Usage: trans. semigroup satisfying IsGroupAsSemigroup" );
  fi;

  return MappingByFunction(s, Group(List(Generators(s), AsPermutation)), 
   AsPermutation);
end);

#IIIOOO

# new for 0.1! - IsOrthodoxSemigroup - "for a transformation semigroup"
###########################################################################
# Notes: is there a better method? JDM

InstallOtherMethod(IsOrthodoxSemigroup, "for a transformation semigroup", 
[IsTransformationSemigroup and HasGeneratorsOfSemigroup], 
function(s)
  local idems, e, f;

  if not IsRegularSemigroup(s) then 
    return false;
  fi;

  idems:=Idempotents(s);

  for e in idems do
    for f in idems do
      if not (e*f)^2=e*f then 
        return false;
      fi;
    od;
  od;

  return true;
end);


#IIIRRR

# new for 0.1! - IsRectangularBand - "for a transformation semigroup"
###########################################################################

InstallMethod(IsRectangularBand, "for a transformation semigroup", 
[IsTransformationSemigroup and HasGeneratorsOfSemigroup],
function(s)

  if not IsSimpleSemigroup(s) then 
    return false;
  elif HasIsBand(s) then
    return IsBand(s);
  fi;

  return IsGreensHTrivial(s);
end);

# new for 0.1! - IsRegularSemigroup - "for a transformation semigroup"
###########################################################################

InstallOtherMethod(IsRegularSemigroup, "for a transformation semigroup", 
[IsTransformationSemigroup and HasGeneratorsOfSemigroup],
function(s)
  local iter, d;

  if IsSimpleSemigroup(s) then 
    return true;
  elif IsCompletelyRegularSemigroup(s) then 
    return true;
  elif HasGreensDClasses(s) then 
    return ForAll(GreensDClasses(s), IsRegularDClass);
  fi;

  iter:=IteratorOfRClassRepsData(s);

  for d in iter do 
    if not IsRegularRClassData(s, d) then 
      return false;
    fi;
  od; 

  return true;
end);

# new for 0.1! - IsRightZeroSemigroup - "for a transformation semigroup"
###########################################################################

InstallMethod(IsRightZeroSemigroup, "for a transformation semigroup", 
[IsTransformationSemigroup and HasGeneratorsOfSemigroup],
function(s)
  local gens, kers;

  gens:=Generators(s);
  kers:=Set(List(gens, CanonicalTransSameKernel));

  if Length(kers)=1 and ForAll(gens, IsIdempotent) then
    return true;
  fi;

  return false;
end);

#IIISSS


# new for 0.1! - IsSemiband - "for a transformation semigroup"
###############################################################################

InstallMethod(IsSemiband, "for a transformation semigroup",
[IsTransformationSemigroup and HasGeneratorsOfSemigroup],
IsIdempotentGenerated);

InstallTrueMethod(IsSemiband, IsIdempotentGenerated);

# new for 0.1! - IsSemilatticeAsSemigroup - "for a trans. semigroup"
###############################################################################

InstallMethod(IsSemilatticeAsSemigroup, "for a transformation semigroup",
[IsTransformationSemigroup and HasGeneratorsOfSemigroup], 
 s-> IsCommutative(s) and IsBand(s));

InstallTrueMethod(IsSemilatticeAsSemigroup, IsCommutative and IsBand);

# new for 0.1! - IsSimpleSemigroup - "for a tran. semi."
###########################################################################

InstallMethod(IsSimpleSemigroup, "for a transformation semigroup", 
[IsTransformationSemigroup and HasGeneratorsOfSemigroup], 
function(s)
  local gens, r, o, f;

  if HasIsRegularSemigroup(s) and not IsRegularSemigroup(s) then 
    return false;
  elif HasIsCompletelyRegularSemigroup(s) and not 
   IsCompletelyRegularSemigroup(s) then 
    return false;
  elif HasNrGreensDClasses(s) then
    return NrGreensDClasses(s)=1;
  fi;

  gens:=GeneratorsOfSemigroup(s); #not GeneratorsOfMonoid!

  for f in gens do
    r:=RankOfTransformation(f);
    o:=Orb(gens, ImageSetOfTransformation(f), OnSets, 
        rec(lookingfor:=function(o, x) return Length(x)<r or not
         IsInjectiveTransOnList(f, x); end));
    Enumerate(o);
    if IsPosInt(PositionOfFound(o)) then 
      return false;
    fi;
  od;

  SetIsCompletelyRegularSemigroup(s, true);
  SetIsRegularSemigroup(s, true);
  SetNrGreensDClasses(s, 1);

  return true;
end);

# new for 0.1! - IsSynchronizingSemigroup - "for a trans. semi. or coll."
###########################################################################

InstallMethod(IsSynchronizingSemigroup, "for a trans. semi. or coll.", 
[IsTransformationSemigroup and HasGeneratorsOfSemigroup],
function(s)
  local n, o;

  n:=DegreeOfTransformationSemigroup(s);

  o:=Orb(s, [1..n], OnSets, 
        rec(lookingfor:=function(o, x) return Length(x)=1; end));

  Enumerate(o);

  return IsPosInt(PositionOfFound(o));
end);

#IIIZZZ

# new for 0.1! - IsZeroGroup - "for a transformation semigroup"
###########################################################################

InstallOtherMethod(IsZeroGroup, "for a transformation semigroup",
[IsTransformationSemigroup and HasGeneratorsOfSemigroup],
function(s)
  local zero;

  zero:=MultiplicativeZero(s);

  if zero=fail then 
    return false;
  fi;

  if NrGreensHClasses(s)=2 then 
    return ForAll(GreensHClasses(s), IsGroupHClass);
  fi;

  return false;
end);

# new for 0.1! - IsZeroSemigroup - "for a transformation semigroup"
###########################################################################

InstallOtherMethod(IsZeroSemigroup, "for a transformation semigroup", 
[IsTransformationSemigroup and HasGeneratorsOfSemigroup],
function(s)
  local z, x, y, gens;

  z:=MultiplicativeZero(s);
  gens:=GeneratorsOfSemigroup(s);

  if z=fail then
    return false;
  fi;

  for x in gens do
    for y in gens do 
      if not x*y=z then 
        return false;
      fi;
    od;
  od;

  return true;
end);

#MMM

# new for 0.1! - MinimalIdeal - "for a transformation semigroup"
###########################################################################

InstallMethod(MinimalIdeal, "for a transformation semigroup", 
[IsTransformationSemigroup and HasGeneratorsOfSemigroup],
function(s)
  local n, gens, max, o, i, bound, f;

  n:=Degree(s);
  gens:=Generators(s);
  max:=Maximum(List(gens, Degree));

  if max=n then 
    bound:=2^n;
  else
    bound:=Sum([1..max], x-> Binomial(n, x));
  fi;

  o:=Orb(gens, [1..n], OnSets, rec( schreier:=true,
   gradingfunc:=function(o, x) return Length(x); end,
    onlygrades:=[1..max],
     lookingfor:=function(o, x) return Length(x)=1; end));
   
  Enumerate(o, bound);

  if IsPosInt(PositionOfFound(o)) then 
    i:=PositionOfFound(o);
  else
    i:=Position(Grades(o), Minimum(Grades(o))); 
  fi;

  f:=EvaluateWord(gens, TraceSchreierTreeForward(o, i));
  #i:=SemigroupIdealByGenerators(s, [f]);
  #SetIsSimpleSemigroup(i, true);
  #SetIsMinimalIdeal(i, true);
  #SetUnderlyingDClassOfMinIdeal(i, GreensDClassOfElement(s, f));
  #return i;
  return Semigroup(Elements(GreensDClassOfElementNC(s, f)));#JDM temp. 
end);

# new for 0.1! - MultiplicativeNeutralElement - "for a trans. semi."
###########################################################################

InstallOtherMethod(MultiplicativeNeutralElement, "for a trans. semigroup",
[IsTransformationSemigroup and HasGeneratorsOfSemigroup], 
function(s)
  local gens, n, f, r;

  gens:=Generators(s);
  n:=Maximum(List(gens, Rank));

  if n=Degree(s) then
    return One(s);
  fi;

  f:=First(gens, f-> Rank(f)=n);

  r:=GreensRClassOfElementNC(s, f); #NC? JDM

  if not NrIdempotents(r)=1 then 
    return fail;
  fi;

  f:=Idempotents(r)[1];

  if ForAll(gens, x-> x*f=x and f*x=x) then 
    return f;
  fi;

  return fail;
end);

# new for 0.1! - MultiplicativeZero - "for a transformation semigroup"
###########################################################################

InstallOtherMethod(MultiplicativeZero, "for a transformation semigroup", 
[IsTransformationSemigroup and HasGeneratorsOfSemigroup], 
function(s)
  local n, gens, max, bound, o, i, f;
  n:=Degree(s); gens:=Generators(s);

  max:=Maximum(List(gens, Degree));
  if max=n then 
    bound:=2^n;
  else
    bound:=Sum([1..max], x-> Binomial(n, x));
  fi;

  o:=Orb(gens, [1..n], OnSets, rec( schreier:=true, 
   gradingfunc:=function(o, x) return Length(x); end,
    onlygrades:=[1..max],
     lookingfor:=function(o, x) return Length(x)=1; end));

  Enumerate(o, bound);

  if IsPosInt(PositionOfFound(o)) then 
    i:=PositionOfFound(o);
  else
    i:=Position(Grades(o), Minimum(Grades(o))); 
  fi;

  f:=EvaluateWord(gens, TraceSchreierTreeForward(o, i));

  if f^2=f and Size(GreensDClassOfElement(s, f))=1 then #JDM NC? D-class?
    return f;
  fi;

  return fail;
end);

#RRR

# new for 0.1! - RedundantGenerator - "for transformations coll."
#############################################################################
# Notes: returns a redundant generator if one is found and otherwise returns
# fail..

InstallMethod(RedundantGenerator, "for transformations coll.",
[IsTransformationCollection],
gens-> First(gens, x-> x in Semigroup(Difference(gens, [x]))));

# new for 0.1! - RedundantGenerator - "for trans semi and trans coll"
#############################################################################
# Notes: returns a redundant generator if one is found and otherwise returns
# fail.

InstallOtherMethod(RedundantGenerator, "for trans semi and trans coll", 
[IsTransformationSemigroup  and HasGeneratorsOfSemigroup, 
IsTransformationCollection],
  function(s, gens)

  if s=Semigroup(gens) then 
    return RedundantGenerator(gens);
  fi;
  Info(InfoWarning, 1, "Usage: trans. semi. and generating set.");
  return fail;
end);

# new for 0.1! - SmallGeneratingSet - "for a trans. coll."
#############################################################################

InstallOtherMethod(SmallGeneratingSet, "for a trans. semi.", 
[IsTransformationSemigroup and HasGeneratorsOfSemigroup],
function(s)
  local gens, i, out, f;
 
  gens:=ShallowCopy(Generators(s));
  gens:=Permuted(gens, Random(SymmetricGroup(Length(gens))));
  Sort(gens, function(x, y) return Rank(x)>Rank(y); end);

  i:=0; out:=[gens[1]]; s:=Semigroup(out);

  repeat
    i:=i+1; f:=gens[i];
    if InfoLevel(InfoCitrusProperties)>1 then
      Print("at \t", i, " of \t", Length(gens), "; \t", Length(out),
      " generators so far\r");
    fi;
          
    if not f in s then 
      Add(out, f); s:=Semigroup(out);
    fi;
  until i=Length(gens);

  if InfoLevel(InfoCitrusProperties)>1 then
    Print("\n");
  fi;
  return out;
end);

#EOF
