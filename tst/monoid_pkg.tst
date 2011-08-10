#############################################################################
##
#W  monoid_pkg.tst
#Y  Copyright (C) 2011                                   James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
#
#############################################################################
##

#ReadTest(Filename(DirectoriesPackageLibrary("citrus","tst"),"monoid_pkg.tst"));
# approx. 9s

# a concatenation of relevant tests from the monoid/tst. 

# Miscellaneous

gap> START_TEST("monoid_pkg.tst 0.1");
gap> LoadPackage("citrus", false);;
gap> g:=CyclicGroup(3);;
gap> r:=GF(2);;
gap> gr:=GroupRing(r, g);;
gap> iso:=IsomorphismTransformationSemigroup(gr);;
gap> s:=Range(iso);;
gap> Size(s);
8
gap> SmallGeneratingSet(s);;
gap> s:=Semigroup(IrredundantGeneratingSubset(last));;
gap> NrGreensDClasses(s);
4
gap> List(GreensDClasses(s), Size);
[ 3, 1, 3, 1 ]
gap> PartialOrderOfDClasses(s);
[ [ 1, 2, 3 ], [ 2, 4 ], [ 3, 4 ], [ 4 ] ]
gap> IsRegularSemigroup(s);
true
gap> ForAll(s, x-> x in s);
true
gap> MultiplicativeNeutralElement(s);
Transformation( [ 1, 2, 3, 4, 5, 6, 7, 8 ] )
gap> List(s, x-> InversesOfTransformation(s, x)); 
[ [ Transformation( [ 1, 2, 3, 4, 5, 6, 7, 8 ] ) ],
  [ Transformation( [ 1, 8, 5, 4, 7, 2, 3, 6 ] ) ],
  [ Transformation( [ 1, 6, 7, 4, 3, 8, 5, 2 ] ) ],
  [ Transformation( [ 1, 4, 1, 4, 1, 4, 1, 4 ] ) ],
  [ Transformation( [ 1, 7, 3, 1, 5, 5, 7, 3 ] ) ],
  [ Transformation( [ 1, 3, 5, 1, 7, 7, 3, 5 ] ) ],
  [ Transformation( [ 1, 5, 7, 1, 3, 3, 5, 7 ] ) ],
  [ Transformation( [ 1, 1, 1, 1, 1, 1, 1, 1 ] ) ] ]
gap> IsMonoidAsSemigroup(s);
true
gap> IsGroupAsSemigroup(s);
false
gap> i:=MinimalIdeal(s);
<semigroup with 1 generator>
gap> Size(i);
1
gap> MultiplicativeZero(s);
Transformation( [ 1, 1, 1, 1, 1, 1, 1, 1 ] )
gap> MultiplicativeZero(s) in i;
true
gap> h:=List(GreensDClasses(s), GroupHClass);;
gap> List(h, x-> StructureDescription(x));
[ "C3", "1", "C3", "1" ]
gap> IsCliffordSemigroup(s);
true

gap> a:=IdempotentNC([ 1, 2, 1, 1, 2, 3, 4, 5 ], [3,5,6,7,8])*(3,5);;
gap> b:=IdempotentNC([ 1, 2, 1, 1, 2, 3, 4, 5 ], [3,5,6,7,8])*(3,6,7,8);;
gap> s:=Semigroup(a,b);;
gap> IsGroupAsSemigroup(s);
true

gap> gens:=[Transformation([3,5,3,3,5,6]), Transformation([6,2,4,2,2,6])];;
gap> S:=Semigroup(gens);;
gap> GroupHClass(GreensDClassOfElement(S, Elements(S)[1]));
{Transformation( [ 5, 5, 5, 5, 5, 6 ] )}
gap> IsomorphismPermGroup(last);
MappingByFunction( {Transformation( [ 5, 5, 5, 5, 5, 6 
 ] )}, Group(()), <Operation "AsPermutation"> )

gap> gens:=[ Transformation( [ 4, 4, 8, 8, 8, 8, 4, 8 ] ),
>   Transformation( [ 8, 2, 8, 2, 5, 5, 8, 8 ] ),
>   Transformation( [ 8, 8, 3, 7, 8, 3, 7, 8 ] ),
>   Transformation( [ 8, 6, 6, 8, 6, 8, 8, 8 ] ) ];;
gap> S:=Semigroup(gens);;
gap> Size(S);
30
gap> NrGreensDClasses(S);
6
gap> List(GreensDClasses(S), Size);
[ 9, 9, 1, 1, 9, 1 ]
gap> IsRegularSemigroup(S);
false
gap> NrGreensRClasses(S);
12
gap> NrGreensLClasses(S);
12
gap> IsBlockGroup(S);
false
gap> NrIdempotents(S);
15
gap> List(GreensDClasses(S), IsRegularDClass);
[ true, false, true, true, true, true ]
gap> d:=GreensDClasses(S)[2];
{Transformation( [ 6, 6, 8, 8, 8, 8, 6, 8 ] )}
gap> GreensRClasses(d);
[ {Transformation( [ 6, 6, 8, 8, 8, 8, 6, 8 ] )}, 
  {Transformation( [ 8, 6, 8, 6, 8, 8, 8, 8 ] )}, 
  {Transformation( [ 8, 8, 8, 6, 8, 8, 6, 8 ] )} ]
gap> GreensLClasses(d);
[ {Transformation( [ 6, 6, 8, 8, 8, 8, 6, 8 ] )}, 
  {Transformation( [ 5, 5, 8, 8, 8, 8, 5, 8 ] )}, 
  {Transformation( [ 3, 3, 8, 8, 8, 8, 3, 8 ] )} ]
gap> SchutzenbergerGroup(d);
Group(())
gap> h:=List(GreensDClasses(S), GroupHClass);
[ {Transformation( [ 2, 2, 8, 8, 8, 8, 2, 8 ] )}, fail, 
  {Transformation( [ 8, 2, 8, 2, 5, 5, 8, 8 ] )}, 
  {Transformation( [ 8, 8, 3, 7, 8, 3, 7, 8 ] )}, 
  {Transformation( [ 8, 5, 5, 8, 5, 8, 8, 8 ] )}, 
  {Transformation( [ 8, 8, 8, 8, 8, 8, 8, 8 ] )} ]
gap> MultiplicativeNeutralElement(S); 
fail
gap> IsMonoidAsSemigroup(S);         
false
gap> GroupOfUnits(S);
fail
gap> MultiplicativeZero(S);
Transformation( [ 8, 8, 8, 8, 8, 8, 8, 8 ] )
gap> h:=Filtered(h, x-> not x=fail);                             
[ {Transformation( [ 2, 2, 8, 8, 8, 8, 2, 8 ] )}, 
  {Transformation( [ 8, 2, 8, 2, 5, 5, 8, 8 ] )}, 
  {Transformation( [ 8, 8, 3, 7, 8, 3, 7, 8 ] )}, 
  {Transformation( [ 8, 5, 5, 8, 5, 8, 8, 8 ] )}, 
  {Transformation( [ 8, 8, 8, 8, 8, 8, 8, 8 ] )} ]
gap> List(h, StructureDescription);
[ "1", "1", "1", "1", "1" ]
gap> IsGreensHTrivial(S);
true
gap> IsGreensLTrivial(S);
false
gap> IsGreensRTrivial(S);
false
gap> NrIdempotents(S);
15
gap> IsIdempotentGenerated(S);
true
gap> IsSemiband(S);
true
gap> IsCommutative(S);
false
gap> IsBand(S);
false

# from greens.tst

gap> gens:=[ Transformation( [ 4, 5, 7, 1, 8, 6, 1, 7 ] ), 
>  Transformation( [ 5, 5, 3, 8, 3, 7, 4, 6 ] ), 
>  Transformation( [ 5, 7, 4, 4, 1, 4, 4, 4 ] ), 
>  Transformation( [ 7, 1, 4, 3, 6, 1, 3, 7 ] ) ];;
gap> m:=Semigroup(gens);;
gap> o:=ImagesOfTransSemigroup(m);; Enumerate(o);;
gap> AsSet(o);
[ [ 1 ], [ 1 .. 8 ], [ 1, 3 ], [ 1, 3, 4 ], [ 1, 3, 4, 6, 7 ],
  [ 1, 3, 4, 7 ], [ 1, 3, 6 ], [ 1, 3, 6, 7 ], [ 1, 3, 7 ], [ 1, 4 ],
  [ 1, 4, 5 ], [ 1, 4, 5, 6, 7, 8 ], [ 1, 4, 5, 7 ], [ 1, 4, 6 ],
  [ 1, 4, 6, 7 ], [ 1, 4, 6, 7, 8 ], [ 1, 4, 7 ], [ 1, 4, 8 ], [ 1, 6 ],
  [ 1, 6, 7 ], [ 1, 6, 7, 8 ], [ 1, 6, 8 ], [ 1, 7 ], [ 1, 7, 8 ], [ 1, 8 ],
  [ 3 ], [ 3, 4 ], [ 3, 4, 5 ], [ 3, 4, 5, 6, 7, 8 ], [ 3, 4, 5, 7 ],
  [ 3, 4, 5, 7, 8 ], [ 3, 4, 5, 8 ], [ 3, 4, 6 ], [ 3, 4, 6, 7 ],
  [ 3, 4, 6, 7, 8 ], [ 3, 4, 6, 8 ], [ 3, 4, 7 ], [ 3, 4, 7, 8 ],
  [ 3, 4, 8 ], [ 3, 5 ], [ 3, 5, 7 ], [ 3, 5, 8 ], [ 3, 6 ], [ 3, 6, 7 ],
  [ 3, 6, 7, 8 ], [ 3, 6, 8 ], [ 3, 7 ], [ 3, 7, 8 ], [ 3, 8 ], [ 4 ],
  [ 4, 5 ], [ 4, 5, 6 ], [ 4, 5, 6, 7 ], [ 4, 5, 6, 7, 8 ], [ 4, 5, 7 ],
  [ 4, 5, 7, 8 ], [ 4, 5, 8 ], [ 4, 6 ], [ 4, 6, 7 ], [ 4, 6, 8 ], [ 4, 7 ],
  [ 4, 7, 8 ], [ 4, 8 ], [ 5 ], [ 5, 6 ], [ 5, 6, 7 ], [ 5, 6, 8 ], [ 5, 7 ],
  [ 5, 7, 8 ], [ 5, 8 ], [ 6 ], [ 6, 7 ], [ 6, 7, 8 ], [ 6, 8 ], [ 7 ],
  [ 7, 8 ], [ 8 ] ]
gap> gens:=[ Transformation( [ 1, 5, 2, 2, 3, 5, 2 ] ), 
>  Transformation( [ 7, 3, 6, 5, 2, 4, 1 ] ), 
>  Transformation( [ 7, 5, 3, 2, 5, 5, 6 ] ) ];;
gap> m:=Monoid(gens);;
gap> o:=ImagesOfTransSemigroup(m);; Enumerate(o);; AsSet(o);
[ [ 1, 2 ], [ 1, 2, 3 ], [ 1, 2, 3, 4, 5 ], [ 1 .. 7 ], [ 1, 2, 3, 4, 6 ], 
  [ 1, 2, 3, 5 ], [ 1, 2, 3, 5, 6 ], [ 1, 2, 3, 6 ], [ 1, 2, 4 ], 
  [ 1, 2, 4, 5 ], [ 1, 2, 4, 5, 6 ], [ 1, 2, 5 ], [ 1, 2, 6 ], [ 1, 3 ], 
  [ 1, 3, 4 ], [ 1, 3, 4, 5, 6 ], [ 1, 3, 4, 6 ], [ 1, 3, 5 ], [ 1, 3, 6 ], 
  [ 1, 4 ], [ 1, 4, 5 ], [ 1, 4, 5, 6 ], [ 1, 4, 6 ], [ 1, 5 ], [ 1, 5, 6 ], 
  [ 1, 6 ], [ 2 ], [ 2, 3 ], [ 2, 3, 4 ], [ 2, 3, 4, 5 ], [ 2, 3, 4, 5, 7 ], 
  [ 2, 3, 4, 6 ], [ 2, 3, 4, 6, 7 ], [ 2, 3, 5 ], [ 2, 3, 5, 6 ], 
  [ 2, 3, 5, 6, 7 ], [ 2, 3, 5, 7 ], [ 2, 3, 6 ], [ 2, 3, 6, 7 ], 
  [ 2, 3, 7 ], [ 2, 4 ], [ 2, 4, 5 ], [ 2, 4, 5, 6 ], [ 2, 4, 5, 6, 7 ], 
  [ 2, 4, 5, 7 ], [ 2, 4, 6 ], [ 2, 4, 7 ], [ 2, 5 ], [ 2, 5, 6 ], 
  [ 2, 5, 7 ], [ 2, 6 ], [ 2, 6, 7 ], [ 2, 7 ], [ 3 ], [ 3, 4 ], [ 3, 4, 5 ], 
  [ 3, 4, 5, 6 ], [ 3, 4, 5, 6, 7 ], [ 3, 4, 6 ], [ 3, 4, 6, 7 ], 
  [ 3, 4, 7 ], [ 3, 5 ], [ 3, 5, 6 ], [ 3, 5, 7 ], [ 3, 6 ], [ 3, 6, 7 ], 
  [ 3, 7 ], [ 4 ], [ 4, 5 ], [ 4, 5, 6 ], [ 4, 5, 6, 7 ], [ 4, 5, 7 ], 
  [ 4, 6 ], [ 4, 6, 7 ], [ 4, 7 ], [ 5 ], [ 5, 6 ], [ 5, 6, 7 ], [ 5, 7 ], 
  [ 6 ], [ 6, 7 ] ]
gap> Length(Enumerate(KernelsOfTransSemigroup(m)));
206
gap> gens:=[ [ Transformation( [ 3, 4, 4, 3, 1, 1, 5 ] ) ], 
> [ Transformation( [ 1, 1, 4, 3 ] ), Transformation( [ 2, 2, 2, 2 ] ), 
> Transformation( [ 3, 3, 1, 4 ] ) ], [ Transformation( [ 4, 4, 2, 3, 3 ]), 
> Transformation( [ 5, 2, 4, 3, 1 ] ) ], 
> [ Transformation( [ 1, 5, 4, 1, 5 ] ), Transformation( [ 2, 4, 1, 3, 1 ] ) ], 
> [ Transformation( [ 4, 1, 2, 3 ] ), Transformation( [ 4, 3, 4, 1 ] ) ], 
> [ Transformation( [ 2, 1, 3, 1, 4, 3 ] ), 
>   Transformation( [ 2, 2, 2, 2, 1, 2 ] ), 
>   Transformation( [ 5, 3, 4, 3, 5, 6 ] ), 
>   Transformation( [ 6, 4, 1, 4, 5, 3 ] ), 
> Transformation( [ 6, 5, 2, 6, 3, 4 ] ) ], 
> [ Transformation( [ 3, 5, 5, 1, 4, 7, 5 ] ) ], 
> [ Transformation( [ 2, 5, 6, 1, 1, 3 ] ), 
> Transformation( [ 3, 1, 6, 2, 5, 2 ] ), 
> Transformation( [ 5, 4, 2, 3, 3, 5 ] ), 
> Transformation( [ 6, 6, 5, 5, 2, 2 ] ) ], 
> [ Transformation( [ 1, 5, 3, 2, 3 ] ), Transformation( [ 4, 3, 2, 5, 2 ] ), 
>   Transformation( [ 5, 4, 1, 2, 2 ] ), Transformation( [ 5, 5, 5, 1, 1 ] ) ], 
> [ Transformation( [ 2, 4, 4, 7, 2, 1, 2 ] ) ], 
> [ Transformation( [ 3, 4, 2, 4, 6, 7, 4 ] ), 
>   Transformation( [ 4, 6, 3, 2, 4, 5, 4 ] ), 
>   Transformation( [ 6, 2, 3, 5, 5, 2, 2 ] ), 
>   Transformation( [ 6, 5, 4, 5, 2, 4, 4 ] ), 
>   Transformation( [ 7, 6, 7, 5, 6, 5, 7 ] ) ], 
>  [ Transformation( [ 3, 2, 3, 3, 1 ] ), 
> Transformation( [ 4, 5, 1, 2, 4 ] ) ], 
>  [ Transformation( [ 1, 4, 3, 4 ] ), Transformation( [ 2, 2, 1, 1 ] ), 
>    Transformation( [ 3, 1, 3, 4 ] ), Transformation( [ 4, 4, 3, 1 ] ) ], 
> [ Transformation( [ 1, 2, 2, 3, 3 ] ), Transformation( [ 4, 3, 4, 3, 2 ] ), 
>   Transformation( [ 5, 3, 4, 5, 4 ] ) ], 
> [ Transformation( [ 4, 3, 6, 4, 6, 1 ] ), 
>   Transformation( [ 4, 4, 4, 6, 3, 1 ] ) ], 
> [ Transformation( [ 1, 4, 3, 4 ] ), Transformation( [ 3, 3, 3, 3 ] ), 
>   Transformation( [ 3, 4, 1, 4 ] ), Transformation( [ 4, 3, 1, 4 ] ) ], 
> [ Transformation( [ 1, 3, 3, 5, 2 ] ), Transformation( [ 3, 4, 5, 1, 1 ] ) ], 
> [ Transformation( [ 2, 6, 4, 6, 5, 2 ] ), 
>   Transformation( [ 3, 5, 6, 2, 5, 1 ] ), 
>   Transformation( [ 5, 1, 3, 3, 3, 1 ] ), 
>   Transformation( [ 6, 4, 4, 6, 6, 3 ] ) ], 
> [ Transformation( [ 1, 3, 3, 3 ] ) ], 
> [ Transformation( [ 4, 1, 2, 2, 3 ] ), Transformation( [ 4, 2, 3, 2, 2 ] ) ], 
> [ Transformation( [ 1, 4, 6, 4, 4, 7, 2 ] ), 
>   Transformation( [ 1, 6, 5, 1, 7, 2, 7 ] ), 
>   Transformation( [ 2, 2, 7, 2, 1, 4, 4 ] ), 
>   Transformation( [ 5, 6, 2, 6, 3, 3, 5 ] ) ], 
> [ Transformation( [ 1, 1, 3, 1 ] ), Transformation( [ 4, 2, 3, 4 ] ), 
>   Transformation( [ 4, 4, 2, 2 ] ) ], [ Transformation( [ 3, 2, 1, 1 ] ), 
>   Transformation( [ 4, 1, 3, 2 ] ), Transformation( [ 4, 4, 1, 2 ] ) ], 
> [ Transformation( [ 1, 6, 4, 2, 5, 3, 2 ] ), 
> Transformation( [ 4, 1, 4, 7, 4, 4, 5 ] ) ], 
>   [ Transformation( [ 2, 4, 5, 4, 4 ] ) ], 
>   [ Transformation( [ 1, 4, 2, 3 ] ), Transformation( [ 4, 3, 3, 3 ] ) ], 
>   [ Transformation( [ 1, 1, 3, 1, 4 ] ) ], 
>   [ Transformation( [ 4, 3, 3, 6, 7, 2, 3 ] ), 
>   Transformation( [ 6, 6, 4, 4, 2, 1, 4 ] ) ], 
>   [ Transformation( [ 2, 2, 4, 6, 4, 3 ] ), 
>   Transformation( [ 3, 4, 1, 1, 5, 2 ] ), 
>   Transformation( [ 4, 4, 6, 4, 6, 1 ] ) ], 
>   [ Transformation( [ 3, 5, 4, 2, 1, 2, 2 ] ), 
>   Transformation( [ 7, 7, 1, 5, 7, 1, 6 ] ) ], 
>   [ Transformation( [ 3, 4, 1, 4 ] ), Transformation( [ 4, 3, 2, 2 ] ), 
>   Transformation( [ 4, 4, 1, 4 ] ) ], 
>   [ Transformation( [ 3, 7, 4, 4, 3, 3, 5 ] ), 
>   Transformation( [ 4, 6, 1, 1, 6, 4, 1 ] ), 
>   Transformation( [ 6, 5, 7, 2, 1, 1, 3 ] ) ], 
>   [ Transformation( [ 1, 2, 4, 1 ] ), Transformation( [ 4, 1, 2, 1 ] ), 
>   Transformation( [ 4, 2, 2, 4 ] ) ], 
>   [ Transformation( [ 2, 1, 2, 2 ] ), Transformation( [ 2, 4, 1, 1 ] ), 
>   Transformation( [ 4, 2, 4, 3 ] ), Transformation( [ 4, 4, 1, 2 ] ) ], 
>   [ Transformation( [ 1, 1, 1, 1, 1, 4 ] ), 
>   Transformation( [ 3, 3, 2, 4, 1, 3 ] ), 
>   Transformation( [ 4, 5, 2, 4, 4, 5 ] ), 
>   Transformation( [ 5, 3, 2, 6, 6, 4 ] ), 
>   Transformation( [ 6, 6, 5, 5, 1, 1 ] ) ], 
>   [ Transformation( [ 1, 2, 4, 1 ] ), Transformation( [ 2, 4, 1, 2 ] ), 
>   Transformation( [ 3, 3, 1, 4 ] ), Transformation( [ 3, 4, 1, 2 ] ), 
>   Transformation( [ 4, 1, 4, 3 ] ) ], 
>   [ Transformation( [ 1, 7, 6, 1, 7, 5, 5 ] ), 
>   Transformation( [ 2, 7, 1, 4, 7, 6, 2 ] ), 
>   Transformation( [ 4, 3, 7, 2, 6, 3, 4 ] ), 
>   Transformation( [ 4, 7, 2, 1, 7, 5, 4 ] ), 
>   Transformation( [ 5, 7, 5, 5, 5, 3, 5 ] ) ], 
>   [ Transformation( [ 2, 4, 4, 3 ] ) ], 
>   [ Transformation( [ 4, 6, 5, 1, 4, 4 ] ) ], 
>   [ Transformation( [ 2, 3, 4, 5, 3 ] ), Transformation( [ 4, 1, 5, 1, 3 ] ), 
>   Transformation( [ 4, 1, 5, 5, 3 ] ) ], 
>   [ Transformation( [ 1, 3, 1, 2, 2 ] ), Transformation( [ 2, 3, 5, 2, 4 ] ), 
>   Transformation( [ 2, 4, 3, 2, 5 ] ), Transformation( [ 4, 4, 2, 1, 2 ] ) ], 
>   [ Transformation( [ 1, 4, 2, 4 ] ), Transformation( [ 2, 2, 1, 4 ] ), 
>   Transformation( [ 3, 2, 2, 2 ] ) ], 
>   [ Transformation( [ 1, 5, 1, 1, 5 ] ), 
> Transformation( [ 4, 3, 1, 3, 2 ] ) ], 
>   [ Transformation( [ 1, 3, 4, 4 ] ), Transformation( [ 2, 1, 3, 3 ] ),
> Transformation( [ 4, 1, 3, 4 ] ), Transformation( [ 4, 2, 3, 3 ] ) ], 
>   [ Transformation( [ 4, 3, 2, 2, 1, 4, 2 ] ), 
>   Transformation( [ 6, 5, 2, 7, 2, 2, 7 ] ) ], 
>   [ Transformation( [ 2, 4, 4, 3 ] ), Transformation( [ 3, 4, 1, 3 ] ), 
>   Transformation( [ 4, 1, 3, 2 ] ), Transformation( [ 4, 4, 1, 1 ] ) ], 
>   [ Transformation( [ 1, 2, 5, 2, 1 ] ), Transformation( [ 3, 2, 2, 4, 2 ] ), 
>   Transformation( [ 4, 5, 1, 1, 2 ] ), Transformation( [ 5, 5, 5, 2, 1 ] ) ],
>   [ Transformation( [ 1, 2, 4, 4 ] ), Transformation( [ 2, 1, 2, 1 ] ), 
>   Transformation( [ 2, 3, 2, 3 ] ), Transformation( [ 3, 2, 1, 3 ] ), 
>   Transformation( [ 3, 4, 3, 2 ] ) ], 
>   [ Transformation( [ 1, 1, 1, 2, 2 ] ) ], 
>   [ Transformation( [ 4, 4, 3, 3, 3, 2 ] ), 
>   Transformation( [ 4, 6, 3, 6, 4, 3 ] ), 
>   Transformation( [ 6, 4, 1, 3, 4, 5 ] ) ], 
>   [ Transformation( [ 1, 1, 4, 3 ] ), Transformation( [ 3, 1, 3, 2 ] ) ], 
>   [ Transformation( [ 1, 3, 5, 3, 3 ] ), Transformation( [ 1, 5, 4, 4, 3 ] ),
>  Transformation( [ 2, 5, 3, 1, 1 ] ) ], 
>   [ Transformation( [ 3, 2, 3, 4 ] ), Transformation( [ 3, 4, 3, 1 ] ),
>  Transformation( [ 3, 4, 4, 4 ] ), Transformation( [ 4, 3, 1, 3 ] ) ], 
>   [ Transformation( [ 2, 2, 5, 2, 2, 5 ] ), 
> Transformation( [ 2, 6, 5, 2, 6, 3 ] ), 
> Transformation( [ 4, 2, 4, 5, 5, 6 ] ), 
>       Transformation( [ 5, 4, 1, 4, 2, 2 ] ) ], 
> [ Transformation( [ 1, 1, 3, 4 ] ), Transformation( [ 3, 1, 2, 2 ] ) ], 
>   [ Transformation( [ 1, 1, 4, 5, 5, 3 ] ), 
> Transformation( [ 6, 4, 4, 5, 6, 5 ] ) ], 
>  [ Transformation( [ 1, 4, 5, 3, 1, 7, 3 ] ), 
>  Transformation( [ 1, 6, 6, 5, 2, 4, 2 ] ) ], 
>   [ Transformation( [ 3, 3, 1, 2, 3 ] ), Transformation( [ 5, 5, 1, 5, 3 ] ),
>  Transformation( [ 5, 5, 5, 5, 2 ] ) ], 
>   [ Transformation( [ 1, 2, 5, 1, 5, 6 ] ), 
>   Transformation( [ 5, 4, 5, 5, 3, 2 ] ) ], 
>   [ Transformation( [ 1, 2, 1, 3 ] ), Transformation( [ 2, 3, 4, 4 ] ),
>  Transformation( [ 4, 1, 1, 1 ] ) ], 
>  [ Transformation( [ 1, 2, 2, 3, 2 ] ), Transformation( [ 4, 3, 2, 4, 1 ] ), 
> Transformation( [ 5, 1, 2, 2, 1 ] ), Transformation( [ 5, 2, 4, 1, 4 ] ), 
> Transformation( [ 5, 5, 4, 2, 2 ] ) ], 
> [ Transformation( [ 2, 1, 2, 3 ] ), Transformation( [ 2, 2, 3, 2 ] ) ], 
> [ Transformation( [ 4, 2, 1, 3 ] ) ], 
>   [ Transformation( [ 1, 2, 3, 4 ] ), Transformation( [ 2, 2, 3, 4 ] ), 
> Transformation( [ 2, 2, 4, 3 ] ) ], 
>   [ Transformation( [ 2, 1, 2, 1 ] ), Transformation( [ 3, 4, 2, 4 ] ) ], 
>   [ Transformation( [ 3, 4, 1, 2, 2, 2 ] ), 
>   Transformation( [ 4, 4, 4, 2, 5, 3 ] ), 
>   Transformation( [ 5, 6, 6, 5, 5, 4 ] ) ], 
>   [ Transformation( [ 1, 4, 1, 6, 4, 6 ] ), 
>   Transformation( [ 2, 4, 2, 5, 5, 6 ] ), 
>   Transformation( [ 3, 6, 2, 1, 4, 6 ] ), 
>   Transformation( [ 4, 6, 2, 4, 1, 2 ] ) ], 
>   [ Transformation( [ 1, 3, 3, 3 ] ), Transformation( [ 2, 1, 3, 1 ] ), 
>   Transformation( [ 3, 1, 2, 3 ] ) ], 
>   [ Transformation( [ 1, 4, 1, 2 ] ), Transformation( [ 2, 2, 3, 2 ] ), 
>   Transformation( [ 3, 3, 4, 3 ] ), Transformation( [ 4, 3, 3, 4 ] ),
>   Transformation( [ 4, 4, 4, 2 ] ) ], 
>   [ Transformation( [ 1, 2, 1, 4 ] ), Transformation( [ 4, 1, 1, 2 ] ), 
>   Transformation( [ 4, 3, 3, 2 ] ) ], 
>   [ Transformation( [ 2, 3, 6, 7, 1, 2, 6 ] ) ], 
>   [ Transformation( [ 4, 1, 1, 3, 3, 3 ] ) ], 
>   [ Transformation( [ 3, 3, 2, 7, 5, 5, 1 ] ), 
>   Transformation( [ 3, 5, 5, 4, 1, 3, 2 ] ), 
>   Transformation( [ 4, 1, 3, 6, 6, 6, 5 ] ), 
>   Transformation( [ 7, 2, 7, 2, 7, 7, 2 ] ) ], 
>   [ Transformation( [ 1, 1, 7, 5, 2, 1, 2 ] ), 
>   Transformation( [ 2, 7, 2, 6, 7, 5, 7 ] ), 
>   Transformation( [ 4, 5, 7, 4, 3, 1, 4 ] ) ], 
>   [ Transformation( [ 3, 6, 4, 4, 2, 5, 1 ] ), 
>   Transformation( [ 4, 1, 2, 5, 7, 7, 3 ] ), 
>   Transformation( [ 4, 4, 1, 1, 6, 2, 7 ] ), 
>   Transformation( [ 5, 7, 6, 6, 1, 4, 5 ] ) ], 
>   [ Transformation( [ 1, 1, 1, 2 ] ), Transformation( [ 1, 3, 1, 3 ] ),
>   Transformation( [ 1, 4, 3, 3 ] ), Transformation( [ 3, 1, 1, 1 ] ), 
>   Transformation( [ 4, 2, 3, 4 ] ) ], 
>   [ Transformation( [ 1, 3, 3, 2, 1, 3 ] ), 
>   Transformation( [ 1, 5, 5, 6, 5, 2 ] ), 
>   Transformation( [ 6, 3, 1, 1, 5, 5 ] ), 
>   Transformation( [ 6, 3, 1, 5, 2, 4 ] ) ], 
>   [ Transformation( [ 2, 6, 1, 3, 1, 5 ] ), 
>   Transformation( [ 4, 3, 3, 5, 5, 5 ] ), 
>   Transformation( [ 4, 5, 6, 4, 4, 2 ] ), 
>   Transformation( [ 6, 3, 5, 4, 1, 4 ] ) ], 
>   [ Transformation( [ 3, 1, 2, 2, 3 ] ), Transformation( [ 3, 2, 1, 2, 5 ] ), 
>       Transformation( [ 3, 3, 4, 2, 4 ] ) ],
>   [ Transformation( [ 1, 7, 1, 6, 6, 5, 3 ] ), 
>   Transformation( [ 2, 6, 5, 6, 1, 5, 6 ] ), 
>   Transformation( [ 3, 4, 6, 1, 5, 1, 6 ] ), 
>   Transformation( [ 7, 5, 7, 2, 5, 7, 4 ] ) ], 
>   [ Transformation( [ 2, 1, 2, 2, 4 ] ), 
>   Transformation( [ 2, 1, 4, 1, 3 ] ), 
>   Transformation( [ 3, 3, 1, 3, 2 ] ), 
>   Transformation( [ 5, 4, 5, 4, 5 ] ) ], 
>   [ Transformation( [ 2, 1, 4, 3 ] ), Transformation( [ 2, 3, 4, 4 ] ), 
>   Transformation( [ 3, 3, 1, 1 ] ) ], 
>   [ Transformation( [ 2, 1, 1, 2 ] ) ], 
>   [ Transformation( [ 1, 3, 1, 3, 3 ] ), Transformation( [ 2, 1, 1, 4, 1 ] ), 
>   Transformation( [ 4, 5, 1, 5, 4 ] ), Transformation( [ 5, 4, 3, 4, 2 ] ),
>   Transformation( [ 5, 5, 5, 3, 4 ] ) ], 
>   [ Transformation( [ 5, 5, 5, 5, 5 ] ) ], 
>   [ Transformation( [ 3, 2, 1, 2, 6, 6 ] ), 
>   Transformation( [ 6, 2, 1, 4, 3, 2 ] ) ], 
>   [ Transformation( [ 3, 4, 4, 2, 4, 7, 2 ] ), 
>   Transformation( [ 4, 1, 7, 7, 7, 1, 3 ] ), 
>   Transformation( [ 5, 5, 5, 4, 4, 3, 4 ] ), 
>   Transformation( [ 6, 6, 6, 3, 6, 7, 2 ] ), 
>   Transformation( [ 7, 7, 5, 1, 7, 2, 3 ] ) ], 
>   [ Transformation( [ 1, 5, 3, 3, 1, 2, 2 ] ), 
>   Transformation( [ 3, 4, 1, 6, 3, 4, 5 ] ), 
>   Transformation( [ 4, 1, 2, 1, 6, 7, 5 ] ), 
>   Transformation( [ 4, 2, 7, 2, 4, 1, 1 ] ), 
>   Transformation( [ 7, 7, 7, 1, 5, 4, 4 ] ) ], 
>   [ Transformation( [ 1, 3, 2, 6, 5, 5 ] ), 
>   Transformation( [ 3, 1, 2, 5, 6, 2 ] ), 
>   Transformation( [ 5, 5, 1, 5, 3, 5 ] ), 
>   Transformation( [ 6, 6, 1, 5, 6, 2 ] ) ], 
>   [ Transformation( [ 1, 4, 3, 3, 4, 3 ] ), 
>   Transformation( [ 3, 1, 2, 5, 2, 5 ] ), 
>   Transformation( [ 3, 2, 1, 6, 5, 4 ] ), 
>   Transformation( [ 5, 2, 1, 1, 3, 1 ] ), 
>   Transformation( [ 6, 4, 1, 1, 1, 1 ] ) ], 
>   [ Transformation( [ 4, 2, 3, 3, 4 ] ) ], 
>   [ Transformation( [ 1, 4, 4, 4, 3, 1, 5 ] ), 
>   Transformation( [ 4, 7, 3, 6, 1, 7, 6 ] ) ], 
>   [ Transformation( [ 4, 3, 5, 7, 7, 1, 6 ] ) ], 
>   [ Transformation( [ 2, 2, 4, 1 ] ) ], 
>   [ Transformation( [ 1, 1, 2, 6, 4, 6 ] ), 
>   Transformation( [ 4, 2, 3, 1, 2, 2 ] ), 
>   Transformation( [ 4, 2, 4, 3, 6, 5 ] ) ], 
>   [ Transformation( [ 2, 3, 6, 4, 7, 4, 6 ] ), 
>   Transformation( [ 4, 4, 3, 2, 6, 4, 6 ] ), 
>   Transformation( [ 4, 6, 6, 5, 4, 6, 7 ] ), 
>   Transformation( [ 5, 6, 1, 6, 3, 5, 1 ] ) ],
>   [ Transformation( [ 1, 1, 5, 3, 1 ] ),
>   Transformation( [ 2, 2, 4, 2, 3 ] ), 
>   Transformation( [ 2, 3, 4, 4, 5 ] ), 
>   Transformation( [ 2, 4, 2, 4, 5 ] ) ], 
>   [ Transformation( [ 3, 1, 1, 5, 3 ] ), 
> Transformation( [ 3, 3, 5, 3, 1 ] ) ], 
>   [ Transformation( [ 4, 3, 3, 5, 2, 5 ] ), 
>   Transformation( [ 6, 1, 2, 4, 1, 3 ] ) ], 
>   [ Transformation( [ 2, 3, 4, 3, 3 ] ), Transformation( [ 3, 5, 2, 4, 2 ] ), 
>   Transformation( [ 3, 5, 2, 5, 2 ] ), 
> Transformation( [ 5, 3, 3, 5, 2 ] ) ] ];;
gap> semis:=List(gens, x-> Semigroup(x));;
gap> res:=List(semis, x-> [NrGreensRClasses(x), Size(x)]);
[ [ 3, 4 ], [ 2, 10 ], [ 3, 14 ], [ 12, 211 ], [ 4, 28 ], [ 378, 4818 ],
  [ 2, 5 ], [ 92, 7142 ], [ 81, 615 ], [ 2, 4 ], [ 158, 2255 ], [ 18, 99 ],
  [ 9, 50 ], [ 16, 76 ], [ 17, 77 ], [ 6, 13 ], [ 19, 330 ], [ 120, 1263 ],
  [ 1, 1 ], [ 14, 53 ], [ 216, 1306 ], [ 6, 12 ], [ 15, 235 ], [ 23, 235 ],
  [ 2, 2 ], [ 3, 9 ], [ 2, 2 ], [ 17, 206 ], [ 22, 506 ], [ 24, 340 ],
  [ 7, 39 ], [ 99, 495 ], [ 10, 18 ], [ 10, 100 ], [ 34, 843 ], [ 14, 210 ],
  [ 546, 3538 ], [ 2, 3 ], [ 2, 3 ], [ 35, 448 ], [ 21, 515 ], [ 9, 14 ],
  [ 5, 11 ], [ 17, 23 ], [ 28, 763 ], [ 15, 199 ], [ 21, 170 ], [ 11, 142 ],
  [ 2, 2 ], [ 33, 1259 ], [ 6, 25 ], [ 64, 426 ], [ 9, 40 ], [ 46, 388 ],
  [ 6, 25 ], [ 11, 49 ], [ 48, 391 ], [ 7, 40 ], [ 13, 18 ], [ 6, 48 ],
  [ 30, 792 ], [ 7, 11 ], [ 1, 3 ], [ 2, 3 ], [ 8, 17 ], [ 15, 115 ],
  [ 49, 1724 ], [ 8, 45 ], [ 6, 46 ], [ 8, 66 ], [ 2, 4 ], [ 1, 3 ],
  [ 322, 4344 ], [ 30, 661 ], [ 1597, 63890 ], [ 10, 76 ], [ 173, 9084 ],
  [ 74, 3931 ], [ 15, 117 ], [ 163, 4804 ], [ 14, 106 ], [ 10, 28 ],
  [ 1, 2 ], [ 53, 328 ], [ 1, 1 ], [ 17, 26 ], [ 172, 1443 ], [ 230, 15176 ],
  [ 83, 1382 ], [ 158, 1074 ], [ 2, 2 ], [ 26, 535 ], [ 3, 6 ], [ 3, 3 ],
  [ 44, 1834 ], [ 158, 1776 ], [ 19, 326 ], [ 9, 45 ], [ 32, 379 ],
  [ 23, 149 ] ]
gap> m:=semis[32];;
gap> Size(m);
495
gap> ForAll(GreensRClasses(m), x-> ForAll(Idempotents(x), y-> y in x));    
true
gap> idem:=Set(Concatenation(List(GreensRClasses(m), Idempotents)));
[ Transformation( [ 1, 1, 1, 1, 1, 1, 1 ] ),
  Transformation( [ 1, 1, 1, 1, 1, 1, 7 ] ),
  Transformation( [ 1, 1, 1, 4, 1, 1, 1 ] ),
  Transformation( [ 1, 1, 3, 1, 1, 1, 1 ] ),
  Transformation( [ 1, 1, 3, 1, 1, 1, 3 ] ),
  Transformation( [ 1, 1, 3, 1, 1, 1, 7 ] ),
  Transformation( [ 1, 1, 3, 3, 1, 1, 1 ] ),
  Transformation( [ 1, 1, 3, 3, 1, 1, 3 ] ),
  Transformation( [ 1, 1, 3, 3, 1, 1, 7 ] ),
  Transformation( [ 1, 1, 3, 6, 6, 6, 7 ] ),
  Transformation( [ 1, 1, 4, 4, 1, 1, 1 ] ),
  Transformation( [ 1, 1, 4, 4, 1, 1, 4 ] ),
  Transformation( [ 1, 1, 7, 1, 1, 1, 7 ] ),
  Transformation( [ 1, 1, 7, 7, 1, 1, 7 ] ),
  Transformation( [ 1, 2, 1, 1, 1, 1, 1 ] ),
  Transformation( [ 1, 2, 1, 1, 1, 1, 2 ] ),
  Transformation( [ 1, 2, 1, 1, 1, 1, 7 ] ),
  Transformation( [ 1, 2, 2, 2, 1, 1, 2 ] ),
  Transformation( [ 1, 2, 2, 2, 2, 1, 2 ] ),
  Transformation( [ 1, 2, 3, 3, 1, 1, 7 ] ),
  Transformation( [ 1, 2, 7, 7, 1, 1, 7 ] ),
  Transformation( [ 1, 3, 3, 3, 1, 1, 3 ] ),
  Transformation( [ 1, 3, 3, 3, 3, 1, 3 ] ),
  Transformation( [ 1, 4, 4, 4, 1, 1, 4 ] ),
  Transformation( [ 1, 4, 4, 4, 4, 1, 4 ] ),
  Transformation( [ 1, 5, 5, 5, 5, 1, 5 ] ),
  Transformation( [ 1, 7, 1, 1, 1, 1, 7 ] ),
  Transformation( [ 1, 7, 3, 3, 1, 1, 7 ] ),
  Transformation( [ 1, 7, 7, 7, 1, 1, 7 ] ),
  Transformation( [ 1, 7, 7, 7, 7, 1, 7 ] ),
  Transformation( [ 2, 2, 2, 2, 2, 2, 2 ] ),
  Transformation( [ 2, 2, 2, 2, 2, 2, 7 ] ),
  Transformation( [ 2, 2, 7, 2, 2, 2, 7 ] ),
  Transformation( [ 2, 2, 7, 7, 2, 2, 7 ] ),
  Transformation( [ 3, 3, 3, 3, 3, 3, 3 ] ),
  Transformation( [ 3, 3, 3, 3, 3, 3, 7 ] ),
  Transformation( [ 3, 3, 3, 4, 3, 3, 3 ] ),
  Transformation( [ 3, 7, 3, 3, 3, 3, 7 ] ),
  Transformation( [ 4, 4, 3, 4, 4, 4, 3 ] ),
  Transformation( [ 4, 4, 3, 4, 4, 4, 4 ] ),
  Transformation( [ 4, 4, 4, 4, 4, 4, 4 ] ),
  Transformation( [ 5, 3, 3, 3, 5, 5, 3 ] ),
  Transformation( [ 5, 4, 4, 4, 5, 5, 4 ] ),
  Transformation( [ 5, 5, 3, 3, 5, 5, 3 ] ),
  Transformation( [ 5, 5, 3, 3, 5, 5, 5 ] ),
  Transformation( [ 5, 5, 3, 3, 5, 5, 7 ] ),
  Transformation( [ 5, 5, 3, 4, 5, 5, 3 ] ),
  Transformation( [ 5, 5, 3, 4, 5, 5, 5 ] ),
  Transformation( [ 5, 5, 3, 4, 5, 5, 7 ] ),
  Transformation( [ 5, 5, 3, 5, 5, 5, 3 ] ),
  Transformation( [ 5, 5, 3, 5, 5, 5, 5 ] ),
  Transformation( [ 5, 5, 3, 5, 5, 5, 7 ] ),
  Transformation( [ 5, 5, 4, 4, 5, 5, 4 ] ),
  Transformation( [ 5, 5, 4, 4, 5, 5, 5 ] ),
  Transformation( [ 5, 5, 5, 4, 5, 5, 5 ] ),
  Transformation( [ 5, 5, 5, 5, 5, 5, 5 ] ),
  Transformation( [ 5, 5, 5, 5, 5, 5, 7 ] ),
  Transformation( [ 5, 5, 7, 5, 5, 5, 7 ] ),
  Transformation( [ 5, 5, 7, 7, 5, 5, 7 ] ),
  Transformation( [ 5, 7, 3, 3, 5, 5, 7 ] ),
  Transformation( [ 5, 7, 5, 5, 5, 5, 7 ] ),
  Transformation( [ 5, 7, 7, 7, 5, 5, 7 ] ),
  Transformation( [ 6, 2, 2, 2, 2, 6, 2 ] ),
  Transformation( [ 6, 2, 2, 2, 6, 6, 2 ] ),
  Transformation( [ 6, 2, 6, 6, 6, 6, 2 ] ),
  Transformation( [ 6, 2, 6, 6, 6, 6, 6 ] ),
  Transformation( [ 6, 3, 3, 3, 3, 6, 3 ] ),
  Transformation( [ 6, 3, 3, 3, 6, 6, 3 ] ),
  Transformation( [ 6, 4, 4, 4, 4, 6, 4 ] ),
  Transformation( [ 6, 4, 4, 4, 6, 6, 4 ] ),
  Transformation( [ 6, 5, 5, 5, 5, 6, 5 ] ),
  Transformation( [ 6, 6, 3, 3, 6, 6, 3 ] ),
  Transformation( [ 6, 6, 3, 3, 6, 6, 6 ] ),
  Transformation( [ 6, 6, 3, 3, 6, 6, 7 ] ),
  Transformation( [ 6, 6, 3, 6, 6, 6, 3 ] ),
  Transformation( [ 6, 6, 3, 6, 6, 6, 6 ] ),
  Transformation( [ 6, 6, 3, 6, 6, 6, 7 ] ),
  Transformation( [ 6, 6, 4, 4, 6, 6, 4 ] ),
  Transformation( [ 6, 6, 4, 4, 6, 6, 6 ] ),
  Transformation( [ 6, 6, 6, 4, 6, 6, 6 ] ),
  Transformation( [ 6, 6, 6, 6, 6, 6, 6 ] ),
  Transformation( [ 6, 6, 6, 6, 6, 6, 7 ] ),
  Transformation( [ 6, 6, 7, 6, 6, 6, 7 ] ),
  Transformation( [ 6, 6, 7, 7, 6, 6, 7 ] ),
  Transformation( [ 6, 7, 3, 3, 6, 6, 7 ] ),
  Transformation( [ 6, 7, 6, 6, 6, 6, 7 ] ),
  Transformation( [ 6, 7, 7, 7, 6, 6, 7 ] ),
  Transformation( [ 6, 7, 7, 7, 7, 6, 7 ] ),
  Transformation( [ 7, 2, 7, 7, 7, 7, 7 ] ),
  Transformation( [ 7, 7, 3, 3, 7, 7, 7 ] ),
  Transformation( [ 7, 7, 3, 7, 7, 7, 7 ] ),
  Transformation( [ 7, 7, 7, 7, 7, 7, 7 ] ) ]
gap> idem=Set(Idempotents(m));
true
gap> H:=GreensHClasses(m);;
gap> I:=Concatenation(List(GreensRClasses(m), GreensHClasses));;
gap> ForAll(H, x-> Number(I, y-> Representative(x) in y)=1);
true
gap> m:=semis[68];;
gap> H:=GreensHClasses(m);;
gap> I:=Concatenation(List(GreensRClasses(m), GreensHClasses));;
gap> ForAll(H, x-> Number(I, y-> Representative(x) in y)=1);
true
gap> m:=semis[74];;
gap> r:=GreensRClassOfElement(m, Transformation( [ 2, 1, 2, 2, 1, 2, 1 ] ));;
gap> d:=DClassOfRClass(r);;
gap> dr:=GreensRClasses(d);;
gap> r2:=First(dr, x-> x=r);;
gap> DClassOfRClass(r2)=d;
true
gap> m:=Semigroup(GeneratorsOfSemigroup(m));
<semigroup with 3 generators>
gap> r:=GreensRClassOfElement(m, Transformation( [ 2, 1, 2, 2, 1, 2, 1 ] ));;
gap> d:=DClassOfRClass(r);;
gap> dr:=GreensRClasses(d);;
gap> r2:=First(dr, x-> x=r);;
gap> DClassOfRClass(r2)=d;
true
gap> res:=List(semis, x-> [Length(GreensLClasses(x)), Size(x)]);     
[ [ 3, 4 ], [ 5, 10 ], [ 2, 14 ], [ 19, 211 ], [ 9, 28 ], [ 46, 4818 ],
  [ 2, 5 ], [ 39, 7142 ], [ 25, 615 ], [ 2, 4 ], [ 789, 2255 ], [ 21, 99 ],
  [ 11, 50 ], [ 25, 76 ], [ 42, 77 ], [ 10, 13 ], [ 23, 330 ], [ 87, 1263 ],
  [ 1, 1 ], [ 24, 53 ], [ 195, 1306 ], [ 9, 12 ], [ 15, 235 ], [ 28, 235 ],
  [ 2, 2 ], [ 7, 9 ], [ 2, 2 ], [ 18, 206 ], [ 26, 506 ], [ 25, 340 ],
  [ 10, 39 ], [ 45, 495 ], [ 13, 18 ], [ 11, 100 ], [ 94, 843 ], [ 15, 210 ],
  [ 80, 3538 ], [ 2, 3 ], [ 2, 3 ], [ 103, 448 ], [ 21, 515 ], [ 10, 14 ],
  [ 7, 11 ], [ 14, 23 ], [ 27, 763 ], [ 14, 199 ], [ 20, 170 ], [ 13, 142 ],
  [ 2, 2 ], [ 30, 1259 ], [ 9, 25 ], [ 23, 426 ], [ 17, 40 ], [ 34, 388 ],
  [ 8, 25 ], [ 13, 49 ], [ 31, 391 ], [ 10, 40 ], [ 17, 18 ], [ 12, 48 ],
  [ 68, 792 ], [ 10, 11 ], [ 1, 3 ], [ 2, 3 ], [ 8, 17 ], [ 22, 115 ],
  [ 201, 1724 ], [ 7, 45 ], [ 10, 46 ], [ 11, 66 ], [ 2, 4 ], [ 1, 3 ],
  [ 363, 4344 ], [ 68, 661 ], [ 2423, 63890 ], [ 11, 76 ], [ 57, 9084 ],
  [ 84, 3931 ], [ 12, 117 ], [ 156, 4804 ], [ 16, 106 ], [ 10, 28 ],
  [ 1, 2 ], [ 52, 328 ], [ 1, 1 ], [ 20, 26 ], [ 257, 1443 ], [ 74, 15176 ],
  [ 333, 1382 ], [ 74, 1074 ], [ 2, 2 ], [ 28, 535 ], [ 3, 6 ], [ 3, 3 ],
  [ 35, 1834 ], [ 93, 1776 ], [ 18, 326 ], [ 16, 45 ], [ 25, 379 ],
  [ 33, 149 ] ]
gap> ForAll(GreensLClasses(m), x-> ForAll(Idempotents(x), y-> y in x));                 
true
gap> idem:=Set(Concatenation(List(GreensLClasses(m), Idempotents)));
[ Transformation( [ 1, 1, 1, 1, 1, 1, 1 ] ),
  Transformation( [ 1, 1, 1, 1, 5, 1, 1 ] ),
  Transformation( [ 1, 1, 1, 1, 5, 1, 5 ] ),
  Transformation( [ 1, 1, 1, 1, 5, 5, 1 ] ),
  Transformation( [ 1, 1, 1, 4, 1, 1, 1 ] ),
  Transformation( [ 1, 1, 1, 4, 1, 4, 1 ] ),
  Transformation( [ 1, 1, 1, 4, 4, 1, 4 ] ),
  Transformation( [ 1, 1, 1, 4, 5, 1, 5 ] ),
  Transformation( [ 1, 1, 1, 5, 5, 1, 5 ] ),
  Transformation( [ 1, 1, 4, 4, 1, 1, 1 ] ),
  Transformation( [ 1, 1, 4, 4, 4, 1, 4 ] ),
  Transformation( [ 1, 1, 5, 5, 5, 1, 5 ] ),
  Transformation( [ 1, 2, 1, 1, 1, 1, 1 ] ),
  Transformation( [ 1, 2, 1, 1, 2, 1, 1 ] ),
  Transformation( [ 1, 2, 1, 1, 2, 1, 2 ] ),
  Transformation( [ 1, 2, 1, 1, 2, 2, 2 ] ),
  Transformation( [ 1, 2, 1, 1, 5, 1, 1 ] ),
  Transformation( [ 1, 2, 1, 2, 2, 1, 2 ] ),
  Transformation( [ 1, 2, 1, 2, 2, 2, 2 ] ),
  Transformation( [ 1, 2, 2, 1, 1, 1, 1 ] ),
  Transformation( [ 1, 2, 2, 1, 1, 2, 1 ] ),
  Transformation( [ 1, 2, 2, 1, 2, 2, 1 ] ),
  Transformation( [ 1, 2, 2, 1, 5, 5, 1 ] ),
  Transformation( [ 1, 4, 1, 4, 4, 1, 4 ] ),
  Transformation( [ 1, 4, 1, 4, 4, 4, 4 ] ),
  Transformation( [ 1, 5, 1, 1, 5, 1, 1 ] ),
  Transformation( [ 1, 5, 1, 1, 5, 1, 5 ] ),
  Transformation( [ 1, 5, 1, 1, 5, 5, 5 ] ),
  Transformation( [ 1, 5, 1, 4, 5, 4, 5 ] ),
  Transformation( [ 1, 5, 1, 5, 5, 1, 5 ] ),
  Transformation( [ 1, 5, 1, 5, 5, 5, 5 ] ),
  Transformation( [ 1, 5, 5, 1, 5, 5, 1 ] ),
  Transformation( [ 2, 2, 2, 2, 2, 2, 2 ] ),
  Transformation( [ 2, 2, 2, 2, 2, 6, 2 ] ),
  Transformation( [ 2, 2, 2, 2, 5, 2, 2 ] ),
  Transformation( [ 2, 2, 2, 2, 5, 2, 5 ] ),
  Transformation( [ 2, 2, 2, 2, 5, 5, 2 ] ),
  Transformation( [ 2, 2, 2, 2, 6, 6, 2 ] ),
  Transformation( [ 2, 2, 2, 2, 7, 2, 7 ] ),
  Transformation( [ 2, 2, 2, 5, 5, 2, 5 ] ),
  Transformation( [ 2, 2, 2, 6, 2, 6, 2 ] ),
  Transformation( [ 2, 2, 2, 7, 7, 2, 7 ] ),
  Transformation( [ 2, 2, 5, 5, 5, 2, 5 ] ),
  Transformation( [ 2, 2, 7, 7, 7, 2, 7 ] ),
  Transformation( [ 3, 3, 3, 3, 3, 3, 3 ] ),
  Transformation( [ 3, 3, 3, 3, 5, 3, 3 ] ),
  Transformation( [ 3, 3, 3, 3, 5, 3, 5 ] ),
  Transformation( [ 3, 3, 3, 3, 5, 5, 3 ] ),
  Transformation( [ 3, 3, 3, 3, 7, 3, 7 ] ),
  Transformation( [ 3, 3, 3, 4, 3, 3, 3 ] ),
  Transformation( [ 3, 3, 3, 4, 3, 4, 3 ] ),
  Transformation( [ 3, 3, 3, 4, 4, 3, 4 ] ),
  Transformation( [ 3, 3, 3, 4, 5, 3, 5 ] ),
  Transformation( [ 3, 3, 3, 4, 7, 3, 7 ] ),
  Transformation( [ 3, 3, 3, 5, 5, 3, 5 ] ),
  Transformation( [ 3, 3, 3, 7, 7, 3, 7 ] ),
  Transformation( [ 3, 4, 3, 4, 4, 3, 4 ] ),
  Transformation( [ 3, 4, 3, 4, 4, 4, 4 ] ),
  Transformation( [ 3, 5, 3, 3, 5, 3, 3 ] ),
  Transformation( [ 3, 5, 3, 3, 5, 3, 5 ] ),
  Transformation( [ 3, 5, 3, 3, 5, 5, 5 ] ),
  Transformation( [ 3, 5, 3, 4, 5, 4, 5 ] ),
  Transformation( [ 3, 5, 3, 5, 5, 3, 5 ] ),
  Transformation( [ 3, 5, 3, 5, 5, 5, 5 ] ),
  Transformation( [ 3, 7, 3, 3, 7, 3, 7 ] ),
  Transformation( [ 3, 7, 3, 3, 7, 7, 7 ] ),
  Transformation( [ 3, 7, 3, 4, 7, 4, 7 ] ),
  Transformation( [ 3, 7, 3, 7, 7, 3, 7 ] ),
  Transformation( [ 3, 7, 3, 7, 7, 7, 7 ] ),
  Transformation( [ 4, 3, 3, 4, 3, 3, 4 ] ),
  Transformation( [ 4, 3, 3, 4, 4, 3, 4 ] ),
  Transformation( [ 4, 3, 3, 4, 4, 4, 4 ] ),
  Transformation( [ 4, 3, 3, 4, 5, 5, 4 ] ),
  Transformation( [ 4, 4, 4, 4, 4, 4, 4 ] ),
  Transformation( [ 4, 4, 4, 4, 5, 4, 4 ] ),
  Transformation( [ 4, 4, 4, 4, 5, 4, 5 ] ),
  Transformation( [ 4, 4, 4, 4, 5, 5, 4 ] ),
  Transformation( [ 4, 4, 4, 4, 7, 4, 7 ] ),
  Transformation( [ 4, 5, 4, 4, 5, 4, 4 ] ),
  Transformation( [ 4, 5, 4, 4, 5, 4, 5 ] ),
  Transformation( [ 4, 5, 4, 4, 5, 5, 5 ] ),
  Transformation( [ 4, 5, 5, 4, 5, 5, 4 ] ),
  Transformation( [ 4, 7, 4, 4, 7, 4, 7 ] ),
  Transformation( [ 4, 7, 4, 4, 7, 7, 7 ] ),
  Transformation( [ 5, 2, 2, 5, 5, 2, 5 ] ),
  Transformation( [ 5, 2, 2, 5, 5, 5, 5 ] ),
  Transformation( [ 5, 2, 5, 5, 5, 5, 5 ] ),
  Transformation( [ 5, 3, 3, 5, 5, 3, 5 ] ),
  Transformation( [ 5, 3, 3, 5, 5, 5, 5 ] ),
  Transformation( [ 5, 5, 3, 3, 5, 5, 5 ] ),
  Transformation( [ 5, 5, 4, 4, 5, 5, 5 ] ),
  Transformation( [ 5, 5, 5, 4, 5, 4, 5 ] ),
  Transformation( [ 5, 5, 5, 4, 5, 5, 5 ] ),
  Transformation( [ 5, 5, 5, 5, 5, 5, 5 ] ),
  Transformation( [ 6, 2, 2, 6, 6, 6, 6 ] ),
  Transformation( [ 6, 2, 6, 2, 2, 6, 2 ] ),
  Transformation( [ 6, 2, 6, 6, 2, 6, 2 ] ),
  Transformation( [ 6, 2, 6, 6, 2, 6, 6 ] ),
  Transformation( [ 6, 2, 6, 6, 6, 6, 6 ] ),
  Transformation( [ 6, 6, 6, 6, 6, 6, 6 ] ),
  Transformation( [ 6, 6, 6, 6, 7, 6, 7 ] ),
  Transformation( [ 6, 6, 6, 7, 7, 6, 7 ] ),
  Transformation( [ 6, 6, 7, 7, 7, 6, 7 ] ),
  Transformation( [ 6, 7, 6, 6, 7, 6, 7 ] ),
  Transformation( [ 6, 7, 6, 7, 7, 6, 7 ] ),
  Transformation( [ 7, 2, 2, 7, 2, 2, 7 ] ),
  Transformation( [ 7, 2, 2, 7, 5, 5, 7 ] ),
  Transformation( [ 7, 2, 2, 7, 6, 6, 7 ] ),
  Transformation( [ 7, 2, 2, 7, 7, 2, 7 ] ),
  Transformation( [ 7, 2, 2, 7, 7, 7, 7 ] ),
  Transformation( [ 7, 2, 7, 7, 2, 7, 7 ] ),
  Transformation( [ 7, 2, 7, 7, 5, 7, 7 ] ),
  Transformation( [ 7, 2, 7, 7, 7, 7, 7 ] ),
  Transformation( [ 7, 3, 3, 7, 3, 3, 7 ] ),
  Transformation( [ 7, 3, 3, 7, 7, 3, 7 ] ),
  Transformation( [ 7, 3, 3, 7, 7, 7, 7 ] ),
  Transformation( [ 7, 5, 5, 7, 5, 5, 7 ] ),
  Transformation( [ 7, 5, 7, 7, 5, 7, 7 ] ),
  Transformation( [ 7, 6, 6, 7, 6, 6, 7 ] ),
  Transformation( [ 7, 6, 6, 7, 7, 6, 7 ] ),
  Transformation( [ 7, 7, 3, 3, 7, 7, 7 ] ),
  Transformation( [ 7, 7, 4, 4, 7, 7, 7 ] ),
  Transformation( [ 7, 7, 7, 4, 7, 4, 7 ] ),
  Transformation( [ 7, 7, 7, 4, 7, 7, 7 ] ),
  Transformation( [ 7, 7, 7, 6, 7, 6, 7 ] ),
  Transformation( [ 7, 7, 7, 7, 5, 5, 7 ] ),
  Transformation( [ 7, 7, 7, 7, 5, 7, 7 ] ),
  Transformation( [ 7, 7, 7, 7, 6, 6, 7 ] ),
  Transformation( [ 7, 7, 7, 7, 7, 6, 7 ] ),
  Transformation( [ 7, 7, 7, 7, 7, 7, 7 ] ) ]
gap> idem=Set(Idempotents(m));
true
gap> m:=semis[30];;
gap> r:=GreensLClassOfElement(m, Transformation( [ 3, 3, 3, 3, 3, 3, 5 ] ));;
gap> d:=DClassOfLClass(r);;
gap> dr:=GreensLClasses(d);;
gap> r2:=First(dr, x-> x=r);;
gap> DClassOfLClass(r2)=d;
true
gap> m:=Semigroup(GeneratorsOfSemigroup(m));
<semigroup with 2 generators>
gap>  r:=GreensLClassOfElement(m, Transformation( [ 3, 3, 3, 3, 3, 3, 5 ] ));
{Transformation( [ 3, 3, 3, 3, 3, 3, 5 ] )}
gap> d:=DClassOfLClass(r);;
gap> dr:=GreensLClasses(d);;
gap> r2:=First(dr, x-> x=r);;
gap> DClassOfLClass(r2)=d;
true
gap> List(semis, s-> Length(GreensHClasses(s)));
[ 3, 5, 3, 77, 13, 1281, 2, 1032, 231, 2, 1355, 57, 28, 48, 57, 12, 139, 508, 
  1, 36, 801, 10, 71, 130, 2, 7, 2, 83, 158, 172, 22, 285, 17, 40, 377, 67, 
  1285, 2, 2, 212, 153, 14, 9, 22, 239, 65, 91, 55, 2, 367, 15, 168, 26, 207, 
  14, 29, 274, 22, 17, 26, 253, 10, 1, 2, 13, 64, 605, 20, 25, 33, 2, 1,
  1520, 307, 9625, 41, 1885, 945, 54, 1297, 58, 18, 1, 173, 1, 25, 737, 2807,
  636, 495, 2, 201, 3, 3, 471, 715, 118, 28, 197, 88 ]
gap> ForAll(semis, s-> Number(GreensHClasses(s), IsGroupHClass)=Length(Idempotents(s)));
true
gap> List(semis, s-> Number(GreensDClasses(s), IsRegularDClass));
[ 1, 2, 2, 4, 3, 6, 1, 5, 4, 1, 6, 3, 3, 4, 3, 3, 4, 4, 1, 4, 6, 4, 4, 4, 1,
  2, 1, 3, 5, 5, 3, 5, 3, 3, 5, 4, 6, 1, 1, 4, 4, 3, 3, 4, 4, 4, 4, 3, 1, 4,
  3, 4, 4, 4, 4, 3, 6, 3, 3, 3, 4, 3, 1, 2, 2, 4, 4, 3, 3, 3, 1, 1, 5, 3, 7,
  3, 5, 5, 5, 5, 2, 3, 1, 4, 1, 4, 5, 6, 5, 5, 1, 3, 1, 1, 6, 4, 3, 3, 4, 3 ]
gap> List(semis, s-> List(GreensDClasses(s), x-> Length(Idempotents(x))));
[ [ 0, 0, 1 ], [ 1, 4 ], [ 1, 2 ], [ 7, 1, 30, 5 ], [ 1, 4, 4 ],
  [ 0, 167, 11, 1, 1, 168, 0, 6, 0 ], [ 0, 1 ], [ 2, 42, 197, 169, 6 ],
  [ 2, 0, 58, 18, 0, 5 ], [ 0, 1 ],
  [ 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 159, 0, 8, 0, 0, 46, 0, 0, 0,
      0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0 ], [ 0, 0, 0, 19, 0, 0, 1, 0, 0, 5 ], [ 2, 11, 0, 4 ],
  [ 0, 0, 2, 1, 0, 0, 14, 4 ], [ 0, 0, 0, 0, 0, 1, 0, 0, 12, 3, 0, 0 ],
  [ 1, 3, 0, 2, 0 ], [ 2, 17, 39, 5 ],
  [ 0, 0, 24, 0, 0, 1, 137, 0, 0, 6, 0, 0, 0, 0, 0, 0 ], [ 1 ],
  [ 0, 0, 1, 10, 0, 1, 0, 0, 0, 3 ],
  [ 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 1, 0, 221, 0, 0, 1, 0, 0, 0, 0, 0,
      0, 0, 7, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0 ], [ 2, 0, 1, 2, 3 ], [ 1, 12, 24, 4 ],
  [ 1, 0, 0, 0, 0, 1, 34, 7 ], [ 0, 1 ], [ 1, 0, 3 ], [ 0, 1 ],
  [ 0, 0, 0, 9, 36, 5 ], [ 1, 0, 17, 0, 50, 1, 5 ], [ 1, 0, 7, 1, 63, 7 ],
  [ 1, 0, 8, 4 ], [ 2, 0, 0, 0, 0, 0, 13, 0, 69, 0, 0, 0, 0, 0, 7, 0, 0, 0, 1
     ], [ 0, 0, 4, 0, 0, 1, 2, 0 ], [ 17, 4, 4 ],
  [ 93, 0, 0, 0, 20, 0, 6, 0, 0, 0, 1, 2, 0 ], [ 1, 10, 24, 4 ],
  [ 0, 0, 0, 0, 0, 105, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0,
      199, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 1 ], [ 0, 1 ],
  [ 0, 1, 0, 13, 0, 0, 0, 0, 0, 48, 0, 0, 0, 5 ], [ 20, 1, 51, 5 ],
  [ 0, 0, 3, 0, 0, 1, 2 ], [ 3, 0, 1, 3 ], [ 0, 1, 0, 0, 3, 0, 0, 0, 1, 2, 0 ]
    , [ 2, 27, 82, 7 ], [ 1, 9, 24, 4 ], [ 0, 0, 1, 3, 38, 0, 5 ],
  [ 6, 24, 4 ], [ 0, 1 ], [ 47, 1, 121, 6 ], [ 1, 0, 5, 4 ],
  [ 14, 0, 0, 1, 0, 42, 5 ], [ 1, 0, 8, 1, 0, 3 ],
  [ 80, 0, 0, 0, 0, 6, 6, 0, 0, 0, 1, 0, 0, 0, 0, 0 ], [ 1, 1, 6, 3 ],
  [ 0, 0, 0, 11, 0, 1, 4 ], [ 0, 1, 20, 6, 65, 1, 4, 0 ], [ 0, 1, 10, 4 ],
  [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0 ], [ 2, 10, 4 ],
  [ 34, 0, 0, 1, 62, 0, 5 ], [ 0, 1, 0, 1, 0, 0, 2 ], [ 1 ], [ 1, 1 ],
  [ 3, 0, 0, 4 ], [ 1, 0, 0, 0, 0, 0, 6, 26, 1 ],
  [ 47, 2, 0, 121, 0, 0, 0, 6, 0, 0 ], [ 10, 2, 3 ], [ 1, 11, 4 ],
  [ 3, 15, 4 ], [ 0, 1 ], [ 1 ],
  [ 0, 0, 0, 0, 248, 3, 0, 0, 0, 0, 1, 0, 0, 122, 0, 7, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0 ], [ 111, 0, 0, 0, 0, 0, 12, 7, 0, 0 ],
  [ 0, 1, 0, 0, 0, 0, 0, 9, 0, 0, 0, 258, 0, 0, 0, 0, 0, 1, 889, 0, 0, 0, 0,
      0, 430, 7, 0, 0, 0, 0, 0, 0 ], [ 20, 0, 1, 4 ],
  [ 1, 324, 0, 12, 231, 6, 0 ],
  [ 0, 0, 143, 0, 0, 0, 1, 0, 163, 3, 0, 0, 6, 0, 0 ], [ 3, 1, 1, 24, 4 ],
  [ 0, 5, 0, 0, 0, 0, 0, 140, 0, 277, 0, 1, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 0, 0, 23, 0, 0, 5 ], [ 1, 0, 4, 0, 4 ], [ 1 ],
  [ 52, 1, 5, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 1 ],
  [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 1, 1 ],
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 177, 11, 0, 0, 7, 0, 0, 0, 0, 0, 0, 1, 0,
      0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
  [ 2, 0, 0, 0, 38, 434, 0, 1, 390, 0, 7 ],
  [ 0, 0, 40, 0, 0, 0, 5, 0, 0, 0, 0, 0, 114, 0, 9, 0, 5, 0, 0, 0, 0, 0, 0,
      0, 0, 0 ], [ 1, 32, 0, 0, 2, 65, 0, 6, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 1 ],
  [ 0, 0, 0, 0, 16, 0, 74, 6 ], [ 0, 0, 1 ], [ 0, 0, 1 ],
  [ 4, 1, 1, 114, 65, 6 ],
  [ 0, 0, 1, 0, 0, 0, 40, 0, 0, 0, 200, 7, 0, 0, 0, 0, 0, 0, 0 ],
  [ 8, 0, 44, 5 ], [ 0, 1, 10, 0, 3 ], [ 0, 1, 0, 6, 73, 6 ],
  [ 0, 0, 0, 0, 0, 0, 33, 0, 1, 0, 4, 0, 0 ] ]
gap> List(semis, x-> [Length(GreensDClasses(x))]);
[ [ 3 ], [ 2 ], [ 2 ], [ 4 ], [ 3 ], [ 9 ], [ 2 ], [ 5 ], [ 6 ], [ 2 ],
  [ 75 ], [ 10 ], [ 4 ], [ 8 ], [ 12 ], [ 5 ], [ 4 ], [ 16 ], [ 1 ], [ 10 ],
  [ 101 ], [ 5 ], [ 4 ], [ 8 ], [ 2 ], [ 3 ], [ 2 ], [ 6 ], [ 7 ], [ 6 ],
  [ 4 ], [ 19 ], [ 8 ], [ 3 ], [ 13 ], [ 4 ], [ 36 ], [ 2 ], [ 2 ], [ 14 ],
  [ 4 ], [ 7 ], [ 4 ], [ 11 ], [ 4 ], [ 4 ], [ 7 ], [ 3 ], [ 2 ], [ 4 ],
  [ 4 ], [ 7 ], [ 6 ], [ 16 ], [ 4 ], [ 7 ], [ 8 ], [ 4 ], [ 13 ], [ 3 ],
  [ 7 ], [ 7 ], [ 1 ], [ 2 ], [ 4 ], [ 9 ], [ 10 ], [ 3 ], [ 3 ], [ 3 ],
  [ 2 ], [ 1 ], [ 54 ], [ 10 ], [ 32 ], [ 4 ], [ 7 ], [ 15 ], [ 5 ], [ 22 ],
  [ 7 ], [ 5 ], [ 1 ], [ 17 ], [ 1 ], [ 14 ], [ 62 ], [ 11 ], [ 26 ], [ 15 ],
  [ 2 ], [ 8 ], [ 3 ], [ 3 ], [ 6 ], [ 19 ], [ 4 ], [ 5 ], [ 6 ], [ 13 ] ]
gap> List(semis, s-> Length(Idempotents(s)));
[ 1, 5, 3, 43, 9, 354, 1, 416, 83, 1, 220, 25, 17, 21, 16, 6, 63, 168, 1, 15,
  240, 8, 41, 43, 1, 4, 1, 50, 74, 79, 13, 92, 7, 25, 122, 39, 314, 1, 1, 67,
  77, 6, 7, 7, 118, 38, 47, 34, 1, 175, 10, 62, 13, 93, 11, 16, 97, 15, 4,
  16, 102, 4, 1, 2, 7, 34, 176, 15, 16, 22, 1, 1, 381, 130, 1595, 25, 574,
  316, 33, 430, 28, 9, 1, 63, 1, 5, 197, 872, 173, 106, 1, 96, 1, 1, 191,
  248, 57, 14, 86, 38 ]
gap> a:=Transformation( [ 2, 1, 4, 5, 6, 3 ] );;
gap> b:=Transformation( [ 2, 3, 1, 5, 4, 1 ] );;
gap> M:=Semigroup(a,b);;
gap> GreensLClassOfElement(M,a);
{Transformation( [ 2, 1, 4, 5, 6, 3 ] )}
gap> IsGreensClassOfTransSemigp(last);
true
gap> f:=FreeSemigroup(3);;
gap> a:=f.1;; b:=f.2;; c:=f.3;; 
gap> s:=f/[[a^2, a], [b^2,b], [c^2,c], [a*b,a], [b*a,b], [a*c,a], [c*a,c], [b*c,b],[c*b,c]] ;
<fp semigroup on the generators [ s1, s2, s3 ]>
gap> Size(s);
3
gap> GreensLClassOfElement(s,a);
{s1}
gap> IsGreensClassOfTransSemigp(last);
false
gap> gens:=[ Transformation( [ 2, 2, 5, 2, 3 ] ), 
> Transformation( [ 2, 5, 3, 5, 3 ] ) ];;
gap> S:=Semigroup(gens);;
gap> f:=Transformation( [ 5, 5, 3, 5, 3 ] );;
gap> GreensHClassOfElement(S, f);;
gap> Representative(last);
Transformation( [ 5, 5, 3, 5, 3 ] )
gap> IsTrivial(SchutzenbergerGroup(last2));
true
gap> gens:=[ Transformation( [ 4, 1, 4, 5, 3 ] ),
> Transformation( [ 5, 3, 5, 4, 3 ] ) ];;
gap> S:=Semigroup(gens);;
gap> C:=GreensLClassOfElement(S, gens[1]*gens[2]*gens[1]);
{Transformation( [ 5, 3, 5, 4, 3 ] )}
gap> gens:=[ Transformation( [ 5, 1, 1, 5, 1 ] ), 
> Transformation( [ 5, 2, 4, 3, 2 ] ) ];;
gap> S:=Semigroup(gens);;
gap> gens:=[ Transformation( [ 1, 2, 1, 2, 1 ] ), 
> Transformation( [ 3, 4, 2, 1, 4 ] ) ];;
gap> S:=Semigroup(gens);; 
gap> GreensRClassReps(S);
[ Transformation( [ 1, 2, 1, 2, 1 ] ), Transformation( [ 3, 4, 2, 1, 4 ] ),
  Transformation( [ 1, 2, 2, 1, 2 ] ), Transformation( [ 2, 1, 2, 1, 1 ] ) ]
gap> a:=Transformation( [ 2, 1, 4, 5, 6, 3 ] );;
gap> b:=Transformation( [ 2, 3, 1, 5, 4, 1 ] );;
gap> M:=Semigroup(a,b);;
gap> rc:=GreensRClassOfElement(M, a*b*a);
{Transformation( [ 3, 2, 5, 4, 1, 1 ] )}
gap> gens:=[ Transformation( [ 3, 5, 2, 5, 1 ] ), 
> Transformation( [ 4, 3, 2, 1, 5 ] ) ];;
gap> S:=Semigroup(gens);;
gap> f:=Transformation( [ 2, 4, 2, 5, 3 ] );;
gap> r:=RClass(S, f);
{Transformation( [ 5, 2, 5, 3, 1 ] )}
gap> ImageOrbit(r);
<closed orbit, 2 images with size 4, 1 components, 2 kernels, 2 reps>
gap> AsList(last);
[ [ 1, 2, 3, 5 ], [ 2, 3, 4, 5 ] ]
gap> ImageOrbitPerms(r){ImageOrbitSCC(r)};
[ (), (1,4)(2,3) ]
gap> SchutzenbergerGroup(r);
Group([ (1,3,2,5) ])
gap> gens:=[ Transformation( [ 4, 1, 5, 2, 4 ] ), 
> Transformation( [ 4, 4, 1, 5, 3 ] ) ];;
gap> gens:=[ Transformation( [ 4, 4, 3, 5, 3 ] ), 
> Transformation( [ 5, 1, 1, 4, 1 ] ), 
> Transformation( [ 5, 5, 4, 4, 5 ] ) ];;
gap> S:=Semigroup(gens);;
gap> f:=Transformation( [ 4, 5, 5, 5, 5 ] );;
gap> SchutzenbergerGroup(GreensDClassOfElement(S, f));
Sym( [ 4 .. 5 ] )
gap> SchutzenbergerGroup(GreensRClassOfElement(S, f));
Group([ (4,5) ])
gap> SchutzenbergerGroup(GreensLClassOfElement(S, f));
Group([ (4,5) ])
gap> SchutzenbergerGroup(GreensHClassOfElement(S, f));
Group([ (4,5) ])
gap>  S:=Semigroup([ Transformation( [ 6, 4, 4, 4, 6, 1 ] ), 
> Transformation( [ 6, 5, 1, 6, 2, 2 ] ) ]);;
gap> AsList(Enumerate(ImagesOfTransSemigroup(S, 6)));
[ [ 1 .. 6 ] ]
gap> AsList(Enumerate(ImagesOfTransSemigroup(S, 5)));
[ [ 1 .. 6 ] ]
gap> AsSet(Enumerate(ImagesOfTransSemigroup(S, 4)));
[ [ 1 .. 6 ], [ 1, 2, 5, 6 ] ]
gap> AsSet(Enumerate(ImagesOfTransSemigroup(S, 3)));
[ [ 1 .. 6 ], [ 1, 2, 5, 6 ], [ 1, 4, 6 ], [ 2, 5, 6 ] ]
gap> AsSet(Enumerate(ImagesOfTransSemigroup(S, 2)));
[ [ 1 .. 6 ], [ 1, 2, 5, 6 ], [ 1, 4 ], [ 1, 4, 6 ], [ 2, 5 ], [ 2, 5, 6 ],
  [ 2, 6 ], [ 4, 6 ] ]
gap> AsSet(Enumerate(ImagesOfTransSemigroup(S, 1)));
[ [ 1 ], [ 1 .. 6 ], [ 1, 2, 5, 6 ], [ 1, 4 ], [ 1, 4, 6 ], [ 2 ], [ 2, 5 ],
  [ 2, 5, 6 ], [ 2, 6 ], [ 4 ], [ 4, 6 ], [ 5 ], [ 6 ] ]
gap> AsSet(Enumerate(ImagesOfTransSemigroup(S)));
[ [ 1 ], [ 1 .. 6 ], [ 1, 2, 5, 6 ], [ 1, 4 ], [ 1, 4, 6 ], [ 2 ], [ 2, 5 ],
  [ 2, 5, 6 ], [ 2, 6 ], [ 4 ], [ 4, 6 ], [ 5 ], [ 6 ] ]
gap> S:=Semigroup([ Transformation( [ 2, 3, 4, 1 ] ), 
> Transformation( [ 3, 3, 1, 1 ] ) ]);;
gap> Idempotents(S, 1);
[  ]
gap> Idempotents(S, 2);                        
[ Transformation( [ 1, 1, 3, 3 ] ), Transformation( [ 2, 2, 4, 4 ] ),
  Transformation( [ 1, 3, 3, 1 ] ), Transformation( [ 4, 2, 2, 4 ] ) ]
gap> Idempotents(S, 3);                        
[  ]
gap> Idempotents(S, 4);                        
[ Transformation( [ 1, 2, 3, 4 ] ) ]
gap> Idempotents(S);
[ Transformation( [ 1, 1, 3, 3 ] ), Transformation( [ 2, 2, 4, 4 ] ),
  Transformation( [ 1, 3, 3, 1 ] ), Transformation( [ 4, 2, 2, 4 ] ),
  Transformation( [ 1, 2, 3, 4 ] ) ]
gap> S:=Semigroup([ Transformation( [ 2, 4, 1, 2 ] ),
> Transformation( [ 3, 3, 4, 1 ] ) ]);;
gap> AsSet(Enumerate(KernelsOfTransSemigroup(S)));   
[ [ 1, 1, 1, 1 ], [ 1, 1, 1, 2 ], [ 1, 1, 2, 1 ], [ 1, 1, 2, 2 ],
  [ 1, 1, 2, 3 ], [ 1, 2, 1, 1 ], [ 1, 2, 2, 1 ], [ 1, 2, 3, 1 ], [ 1 .. 4 ] ]
gap> AsSet(Enumerate(KernelsOfTransSemigroup(S,1)));
[ [ 1, 1, 1, 1 ], [ 1, 1, 1, 2 ], [ 1, 1, 2, 1 ], [ 1, 1, 2, 2 ],
  [ 1, 1, 2, 3 ], [ 1, 2, 1, 1 ], [ 1, 2, 2, 1 ], [ 1, 2, 3, 1 ], [ 1 .. 4 ] ]
gap> AsSet(Enumerate(KernelsOfTransSemigroup(S,2)));
[ [ 1, 1, 1, 2 ], [ 1, 1, 2, 1 ], [ 1, 1, 2, 2 ], [ 1, 1, 2, 3 ],
  [ 1, 2, 1, 1 ], [ 1, 2, 2, 1 ], [ 1, 2, 3, 1 ], [ 1 .. 4 ] ]
gap> AsSet(Enumerate(KernelsOfTransSemigroup(S,3)));
[ [ 1, 1, 2, 3 ], [ 1, 2, 3, 1 ], [ 1 .. 4 ] ]
gap> AsSet(Enumerate(KernelsOfTransSemigroup(S,4)));  
[ [ 1 .. 4 ] ]

# from install_no_grape.tst

gap> gens:= [ Transformation( [ 4, 3, 3, 6, 7, 2, 3 ] ),
>   Transformation( [ 6, 6, 4, 4, 2, 1, 4 ] ) ];;
gap> s:=Semigroup(gens);;
gap> Length(GreensRClasses(s));
17
gap> s:=Semigroup(gens);;
gap> NrGreensRClasses(s);
17
gap> f:=Transformation( [ 3, 3, 3, 3, 3, 2, 3 ] );;
gap> r:=RClass(s, f);
{Transformation( [ 3, 3, 3, 3, 3, 2, 3 ] )}
gap> ImageOrbit(r);
<closed orbit, 7 images with size 2, 1 components, 9 kernels, 9 reps>
gap> AsSet(ImageOrbit(r));
[ [ 1, 4 ], [ 1, 6 ], [ 2, 3 ], [ 2, 4 ], [ 2, 6 ], [ 3, 6 ], [ 4, 6 ] ]
gap> ImageOrbitPerms(r);
[ (), (2,4,3,5,6), (3,4,5,6), (1,2)(3,4), (1,3,4,5,6,2), (3,4), (2,4,5,6,3) ]
gap> SchutzenbergerGroup(r);
Group([ (2,3) ])
gap> Number(GreensDClasses(s), IsRegularDClass);
3
gap> s:=Semigroup(gens);
<semigroup with 2 generators>
gap> NrRegularDClasses(s);
3

gap> g1:=Transformation([2,2,4,4,5,6]);;
gap> g2:=Transformation([5,3,4,4,6,6]);;
gap> m1:=Monoid(g1,g2);;
gap> g1:=Transformation([5,4,4,2,1]);;
gap> g2:=Transformation([2,5,5,4,1]);;
gap> m2:=Monoid(g1,g2);;
gap> g1:=Transformation([1,2,1,3,3]);;
gap> g2:=Transformation([2,2,3,5,5]);;
gap> m3:=Monoid(g1,g2);;
gap> g1:=Transformation( [ 8, 7, 5, 3, 1, 3, 8, 8 ] );;
gap> g2:=Transformation( [ 5, 1, 4, 1, 4, 4, 7, 8 ] );;
gap> m4:=Monoid(g1,g2);;
gap> g1:=Transformation([3,1,2,3,2,3,2,3]);;
gap> g2:=Transformation([2,5,8,5,2,5,7,8]);;
gap> m5:=Monoid(g1,g2);;
gap> g1:=Transformation([3,3,2,6,2,4,4,6]);;
gap> g2:=Transformation([5,1,7,8,7,5,8,1]);;
gap> m6:=Semigroup(g1,g2);;
gap> g1:=Transformation([3,3,2,6,2,4,4,6,3,4,6]);;
gap> g2:=Transformation([4,4,6,1,3,3,3,3,11,11,11]);;
gap> m7:=Monoid(g1,g2);; #(this is a good example!)
gap> g1:=Transformation([3,3,2,6,2,4,4,6,3,4,6]);;
gap> g2:=Transformation([4,4,6,1,3,3,3,3,11,11,11]);;
gap> g3:=Transformation([2,2,3,4,4,6,6,6,6,6,11]);;
gap> m8:=Monoid(g1,g2,g3);;
gap> g1:=Transformation([3,3,2,6,2,4,4,6,3,4,6]);;
gap> g2:=Transformation([4,4,6,1,3,3,3,3,11,11,11]);;
gap> g3:=Transformation([2,2,3,4,4,6,6,6,6,6,11]);;
gap> g4:=Transformation([2,2,3,4,4,6,6,6,6,11,11]);;
gap> m9:=Monoid(g1, g2, g3, g4);;
gap> g1:=Transformation( [ 12, 3, 6, 4, 6, 11, 9, 6, 6, 7, 6, 12 ] );;
gap> g2:=Transformation( [ 10, 7, 2, 11, 7, 3, 12, 4, 3, 8, 7, 5 ] );;
gap> m11:=Monoid(g1,g2);;
gap> g1:=Transformation( [ 3, 2, 12, 2, 7, 9, 4, 2, 1, 12, 11, 12 ] );;
gap> g2:=Transformation( [ 3, 6, 12, 7, 2, 2, 3, 6, 1, 7, 11, 1 ] );;
gap> m14:=Monoid(g1, g2);;
gap> g1:=Transformation([2,2,3,4,5,6]);;
gap> g2:=Transformation([2,3,4,5,6,1]);;
gap> m15:=Monoid(g1, g2);;
gap> g1:=Transformation([2,1,4,5,6,7,3,2,1]);;
gap> g2:=Transformation([2,1,4,2,1,4,2,1,4]);;
gap> m18:=Monoid(g1, g2);;
gap> g1:=Transformation( [ 5, 2, 5, 5, 8, 10, 8, 5, 2, 10 ] );;
gap> g2:=Transformation( [ 2,2,5,5,5,8,8,8,8,8]);;
gap> m22:=Monoid(g1,g2);;
gap> g1:=Transformation( [ 4, 6, 3, 8, 5, 6, 10, 4, 3, 7 ] );;
gap> g2:=Transformation( [ 5, 6, 6, 3, 8, 6, 3, 7, 8, 4 ] );;
gap> g3:=Transformation( [ 8, 6, 3, 2, 8, 10, 9, 2, 6, 2 ] );;
gap> m23:=Monoid(g1,g2,g3);;

gap> SmallMonoids:=[m1, m2, m3, m4, m5, m6, m7, m8, m9, m11, m14, m15, m18,
> m22, m23];;
gap> List(SmallMonoids, IsCompletelyRegularSemigroup);
[ false, true, false, false, true, true, true, true, true, false, false,
  false, false, true, false ]
gap> List(SmallMonoids, IsRegularSemigroup);
[ false, true, false, false, true, true, true, true, true, false, false,
  true, true, true, false ]
gap> List(SmallMonoids, IsSimpleSemigroup);
[ false, false, false, false, false, true, false, false, false, false, false,
  false, false, false, false ]
gap> List(SmallMonoids, IsCompletelySimpleSemigroup);
[ false, false, false, false, false, true, false, false, false, false, false,
  false, false, false, false ]
gap> List(SmallMonoids, IsInverseSemigroup);
[ false, true, false, false, false, false, false, false, false, false, false,
  false, false, false, false ]
gap> List(SmallMonoids, IsCliffordSemigroup);
[ false, true, false, false, false, false, false, false, false, false, false,
  false, false, false, false ]
gap> List(SmallMonoids, IsGroupAsSemigroup);
[ false, false, false, false, false, false, false, false, false, false,
  false, false, false, false, false ]
gap> List(SmallMonoids, IsZeroSemigroup);
[ false, false, false, false, false, false, false, false, false, false,
  false, false, false, false, false ]
gap> List(SmallMonoids, IsLeftZeroSemigroup);
[ false, false, false, false, false, false, false, false, false, false,
  false, false, false, false, false ]
gap> List(SmallMonoids, IsRightZeroSemigroup);
[ false, false, false, false, false, false, false, false, false, false,
  false, false, false, false, false ]
gap> List(SmallMonoids, IsCommutativeSemigroup);
[ false, false, false, false, false, false, false, false, false, false,
  false, false, false, false, false ]
gap> List(SmallMonoids, IsZeroGroup);
[ false, false, false, false, false, false, false, false, false, false,
  false, false, false, false, false ]

gap> gens:=[ Transformation( [ 2, 4, 1, 5, 4, 4, 7, 3, 8, 1 ] ),
>   Transformation( [ 3, 2, 8, 8, 4, 4, 8, 6, 5, 7 ] ),
>   Transformation( [ 4, 10, 6, 6, 1, 2, 4, 10, 9, 7 ] ),
>   Transformation( [ 6, 2, 2, 4, 9, 9, 5, 10, 1, 8 ] ),
>   Transformation( [ 6, 4, 1, 6, 6, 8, 9, 6, 2, 2 ] ),
>   Transformation( [ 6, 8, 1, 10, 6, 4, 9, 1, 9, 4 ] ),
>   Transformation( [ 8, 6, 2, 3, 3, 4, 8, 6, 2, 9 ] ),
>   Transformation( [ 9, 1, 2, 8, 1, 5, 9, 9, 9, 5 ] ),
>   Transformation( [ 9, 3, 1, 5, 10, 3, 4, 6, 10, 2 ] ),
>   Transformation( [ 10, 7, 3, 7, 1, 9, 8, 8, 4, 10 ] ) ];;
gap> s:=Semigroup(gens);;
gap> o:=Orb(s, [1,2,3,4], OnSets);
<open orbit, 1 points>
gap> 
gap> Enumerate(o);
<closed orbit, 351 points>
gap> StrongOrbitsInForwardOrbit(o);
[ [ [ 9 ], [ 4 ], [ 5 ], [ 6 ], [ 3 ], [ 8 ], [ 10 ], [ 1 ], [ 2 ], [ 7 ] ], 
  [ [ 4, 6 ], [ 2, 6 ], [ 2, 10 ], [ 4, 8 ], [ 6, 10 ], [ 4, 9 ], [ 5, 8 ], 
      [ 1, 8 ], [ 4, 10 ], [ 7, 8 ], [ 6, 8 ], [ 5, 9 ], [ 4, 5 ], [ 1, 7 ], 
      [ 8, 10 ], [ 1, 4 ], [ 8, 9 ], [ 1, 9 ], [ 3, 5 ], [ 1, 6 ], [ 3, 4 ], 
      [ 2, 8 ], [ 3, 6 ], [ 2, 4 ], [ 2, 9 ], [ 4, 7 ], [ 3, 8 ], [ 1, 3 ], 
      [ 1, 2 ], [ 2, 3 ], [ 3, 7 ], [ 2, 5 ], [ 1, 10 ], [ 3, 10 ], [ 6, 7 ], 
      [ 7, 10 ], [ 3, 9 ], [ 6, 9 ], [ 9, 10 ], [ 7, 9 ], [ 1, 5 ], [ 5, 7 ], 
      [ 5, 6 ], [ 2, 7 ], [ 5, 10 ] ], 
  [ [ 2, 4, 5 ], [ 6, 8, 10 ], [ 1, 3, 4 ], [ 2, 3, 8 ], [ 1, 4, 6 ], 
      [ 4, 6, 10 ], [ 2, 6, 8 ], [ 2, 4, 6 ], [ 2, 4, 8 ], [ 1, 8, 9 ], 
      [ 4, 8, 10 ], [ 5, 8, 9 ], [ 3, 4, 8 ], [ 3, 7, 8 ], [ 1, 6, 9 ], 
      [ 2, 4, 9 ], [ 8, 9, 10 ], [ 7, 9, 10 ], [ 1, 5, 8 ], [ 3, 6, 8 ], 
      [ 1, 3, 6 ], [ 2, 5, 9 ], [ 1, 2, 9 ], [ 2, 3, 5 ], [ 1, 6, 10 ], 
      [ 4, 8, 9 ], [ 4, 7, 8 ], [ 1, 9, 10 ], [ 4, 6, 9 ], [ 4, 9, 10 ], 
      [ 1, 4, 8 ], [ 7, 8, 10 ], [ 1, 4, 9 ], [ 2, 5, 8 ], [ 2, 9, 10 ], 
      [ 2, 6, 9 ], [ 4, 7, 9 ], [ 1, 4, 5 ], [ 1, 7, 10 ], [ 1, 2, 7 ], 
      [ 3, 4, 9 ], [ 1, 2, 6 ], [ 4, 6, 8 ], [ 2, 6, 10 ], [ 2, 8, 9 ], 
      [ 1, 2, 10 ], [ 1, 2, 4 ], [ 3, 5, 9 ], [ 4, 5, 8 ], [ 5, 6, 10 ], 
      [ 2, 3, 10 ], [ 3, 7, 10 ], [ 4, 6, 7 ], [ 7, 8, 9 ], [ 5, 6, 8 ], 
      [ 3, 4, 6 ], [ 1, 6, 8 ], [ 2, 4, 10 ], [ 6, 7, 10 ], [ 2, 4, 7 ], 
      [ 3, 4, 5 ], [ 1, 3, 7 ], [ 3, 8, 10 ], [ 6, 7, 8 ], [ 6, 8, 9 ], 
      [ 4, 5, 6 ], [ 3, 5, 10 ], [ 2, 3, 9 ], [ 6, 9, 10 ], [ 4, 5, 7 ], 
      [ 4, 5, 10 ], [ 2, 5, 10 ], [ 3, 6, 9 ], [ 1, 3, 10 ], [ 1, 2, 8 ], 
      [ 2, 3, 6 ], [ 1, 2, 5 ], [ 3, 9, 10 ], [ 5, 7, 8 ], [ 5, 9, 10 ], 
      [ 1, 5, 9 ], [ 1, 4, 10 ], [ 3, 8, 9 ], [ 1, 3, 8 ], [ 1, 2, 3 ], 
      [ 1, 3, 9 ], [ 3, 5, 8 ], [ 3, 4, 10 ], [ 1, 7, 9 ], [ 1, 5, 6 ], 
      [ 2, 7, 8 ], [ 3, 4, 7 ], [ 1, 5, 7 ], [ 1, 8, 10 ], [ 4, 7, 10 ], 
      [ 3, 6, 7 ], [ 1, 4, 7 ], [ 2, 5, 7 ], [ 1, 7, 8 ], [ 2, 3, 7 ], 
      [ 4, 5, 9 ], [ 5, 6, 9 ], [ 2, 3, 4 ], [ 1, 3, 5 ], [ 6, 7, 9 ], 
      [ 3, 7, 9 ], [ 1, 6, 7 ], [ 2, 7, 9 ], [ 3, 6, 10 ], [ 2, 6, 7 ], 
      [ 2, 8, 10 ], [ 2, 5, 6 ], [ 1, 5, 10 ], [ 2, 7, 10 ], [ 3, 5, 6 ], 
      [ 5, 8, 10 ], [ 3, 5, 7 ], [ 5, 6, 7 ] ], 
  [ [ 1, 2, 3, 4 ], [ 1, 2, 4, 5 ], [ 2, 3, 4, 8 ], [ 1, 2, 8, 9 ], 
      [ 2, 3, 5, 6 ], [ 1, 4, 6, 8 ], [ 1, 4, 6, 10 ], [ 4, 6, 8, 9 ], 
      [ 3, 4, 5, 8 ], [ 1, 3, 4, 5 ], [ 2, 4, 6, 9 ], [ 2, 4, 6, 8 ], 
      [ 1, 5, 8, 9 ], [ 2, 3, 6, 8 ], [ 1, 2, 5, 9 ], [ 1, 2, 6, 9 ], 
      [ 2, 3, 4, 5 ], [ 1, 6, 8, 10 ], [ 3, 4, 6, 7 ], [ 3, 7, 8, 9 ], 
      [ 4, 6, 9, 10 ], [ 4, 5, 7, 8 ], [ 1, 6, 9, 10 ], [ 1, 6, 8, 9 ], 
      [ 3, 6, 9, 10 ], [ 2, 6, 7, 9 ], [ 2, 4, 5, 8 ], [ 3, 5, 6, 10 ], 
      [ 1, 2, 3, 10 ], [ 4, 6, 7, 10 ], [ 2, 4, 6, 7 ], [ 4, 8, 9, 10 ], 
      [ 2, 3, 6, 9 ], [ 1, 2, 4, 8 ], [ 2, 4, 6, 10 ], [ 2, 4, 7, 8 ], 
      [ 1, 8, 9, 10 ], [ 1, 4, 6, 9 ], [ 3, 5, 9, 10 ], [ 1, 3, 4, 10 ], 
      [ 2, 5, 8, 9 ], [ 2, 4, 5, 6 ], [ 1, 2, 6, 10 ], [ 2, 4, 7, 10 ], 
      [ 1, 4, 5, 7 ], [ 2, 4, 5, 7 ], [ 6, 8, 9, 10 ], [ 1, 3, 4, 8 ], 
      [ 1, 5, 6, 9 ], [ 1, 2, 4, 9 ], [ 1, 2, 4, 6 ], [ 3, 4, 6, 8 ], 
      [ 1, 3, 5, 6 ], [ 1, 3, 9, 10 ], [ 3, 5, 7, 8 ], [ 1, 3, 4, 7 ], 
      [ 3, 7, 8, 10 ], [ 2, 6, 8, 9 ], [ 4, 7, 8, 9 ], [ 4, 5, 6, 10 ], 
      [ 1, 2, 6, 7 ], [ 7, 8, 9, 10 ], [ 1, 3, 7, 8 ], [ 2, 5, 6, 10 ], 
      [ 3, 4, 6, 9 ], [ 1, 4, 9, 10 ], [ 2, 3, 8, 9 ], [ 3, 4, 7, 8 ], 
      [ 1, 3, 5, 7 ], [ 2, 5, 6, 9 ], [ 2, 3, 4, 6 ], [ 1, 4, 8, 10 ], 
      [ 3, 6, 8, 9 ], [ 3, 4, 8, 9 ], [ 1, 5, 6, 10 ], [ 2, 3, 9, 10 ], 
      [ 1, 4, 8, 9 ], [ 4, 7, 8, 10 ], [ 4, 5, 8, 10 ], [ 1, 7, 8, 10 ], 
      [ 3, 6, 7, 8 ], [ 2, 5, 9, 10 ], [ 1, 4, 7, 10 ], [ 2, 4, 5, 9 ], 
      [ 4, 5, 6, 8 ], [ 1, 7, 8, 9 ], [ 3, 5, 6, 8 ], [ 1, 3, 6, 10 ], 
      [ 1, 2, 6, 8 ], [ 2, 6, 9, 10 ], [ 2, 7, 9, 10 ], [ 4, 7, 9, 10 ], 
      [ 2, 4, 5, 10 ], [ 2, 3, 5, 10 ], [ 1, 3, 7, 10 ], [ 2, 5, 6, 8 ], 
      [ 1, 6, 7, 10 ], [ 2, 3, 4, 9 ], [ 1, 3, 5, 10 ], [ 1, 2, 9, 10 ], 
      [ 2, 3, 5, 7 ], [ 1, 4, 6, 7 ], [ 4, 5, 6, 9 ], [ 1, 4, 7, 9 ], 
      [ 1, 4, 5, 6 ], [ 1, 7, 9, 10 ], [ 2, 4, 9, 10 ], [ 6, 7, 9, 10 ], 
      [ 1, 4, 7, 8 ], [ 2, 3, 4, 10 ], [ 1, 2, 5, 8 ], [ 1, 2, 3, 5 ], 
      [ 2, 4, 8, 9 ], [ 1, 2, 4, 10 ], [ 2, 3, 5, 9 ], [ 4, 6, 8, 10 ], 
      [ 2, 6, 7, 10 ], [ 4, 6, 7, 8 ], [ 3, 4, 5, 6 ], [ 1, 3, 7, 9 ], 
      [ 1, 2, 7, 8 ], [ 2, 3, 4, 7 ], [ 1, 2, 5, 6 ], [ 3, 4, 8, 10 ], 
      [ 2, 4, 8, 10 ], [ 2, 6, 7, 8 ], [ 3, 4, 5, 7 ], [ 1, 4, 5, 10 ], 
      [ 4, 5, 9, 10 ], [ 1, 6, 7, 9 ], [ 3, 4, 9, 10 ], [ 1, 2, 5, 10 ], 
      [ 3, 4, 7, 10 ], [ 1, 4, 5, 8 ], [ 5, 6, 9, 10 ], [ 1, 2, 7, 9 ], 
      [ 2, 3, 5, 8 ], [ 2, 3, 7, 8 ], [ 1, 3, 4, 6 ], [ 1, 3, 5, 9 ], 
      [ 3, 7, 9, 10 ], [ 4, 6, 7, 9 ], [ 3, 4, 5, 10 ], [ 1, 4, 5, 9 ], 
      [ 2, 4, 7, 9 ], [ 2, 5, 7, 8 ], [ 3, 4, 6, 10 ], [ 1, 5, 6, 8 ], 
      [ 3, 4, 5, 9 ], [ 1, 2, 4, 7 ], [ 5, 6, 8, 9 ], [ 1, 5, 7, 8 ], 
      [ 1, 2, 3, 9 ], [ 1, 3, 8, 9 ], [ 1, 2, 3, 8 ], [ 1, 3, 6, 9 ], 
      [ 1, 2, 5, 7 ], [ 1, 2, 3, 7 ], [ 1, 3, 4, 9 ], [ 1, 5, 9, 10 ], 
      [ 5, 6, 8, 10 ], [ 2, 3, 6, 10 ], [ 1, 2, 7, 10 ], [ 1, 3, 5, 8 ], 
      [ 1, 3, 8, 10 ], [ 2, 6, 8, 10 ], [ 2, 8, 9, 10 ], [ 2, 5, 6, 7 ], 
      [ 1, 2, 8, 10 ], [ 2, 3, 6, 7 ], [ 3, 4, 7, 9 ], [ 5, 6, 7, 8 ], 
      [ 1, 5, 8, 10 ], [ 2, 5, 8, 10 ], [ 4, 5, 6, 7 ], [ 3, 5, 6, 7 ], 
      [ 3, 5, 6, 9 ], [ 4, 5, 8, 9 ] ] ]


gap> STOP_TEST( "monoid_pkg.tst 0.1", 1000);
