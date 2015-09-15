/*******************************************************************************
 * Semigroups GAP package
 *
 * This file contains converters from GAP to C++ elements and back.
 *
*******************************************************************************/

#include "converter.h"
#include "types.h"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Boolean matrices
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

BooleanMat* BoolMatConverter::convert (Obj o, size_t n) {
  assert(IS_BOOL_MAT(o));
  assert(LEN_PLIST(o) > 0);
  assert(IS_BLIST_REP(ELM_PLIST(o, 1)));
  assert(sqrt(n) == LEN_BLIST(ELM_PLIST(o, 1)));

  std::vector<bool>* x(new std::vector<bool>());
  x->resize(n, false);

  n = LEN_BLIST(ELM_PLIST(o, 1));

  for (size_t i = 0; i < n; i++) {
    Obj row = ELM_PLIST(o, i + 1);
    assert(IS_BLIST_REP(row));
    for (size_t j = 0; j < n; j++) {
      if (ELM_BLIST(row, j + 1) == True) {
        x->at(i * n + j) = true;
      }
    }
  }
  return new BooleanMat(x);
}

Obj BoolMatConverter::unconvert (Element* x) {
  size_t n = x->degree();
  BooleanMat* xx(static_cast<BooleanMat*>(x));

  Obj o = NEW_PLIST(T_PLIST, n);
  SET_LEN_PLIST(o, n);

  for (size_t i = 0; i < n; i++) {
    Obj blist = NewBag(T_BLIST, SIZE_PLEN_BLIST(n));
    SET_LEN_BLIST(blist, n);
    for (size_t j = 0; j < n; j++) {
      if (xx->at(i * n + j)) {
        SET_ELM_BLIST(blist, j + 1, True);
      } else {
        SET_ELM_BLIST(blist, j + 1, False);
      }
    }
    SET_ELM_PLIST(o, i + 1, blist);
    CHANGED_BAG(o);
  }
  return CALL_2ARGS(Objectify, BooleanMatType, o);
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Bipartitions
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

Bipartition* BipartConverter::convert (Obj o, size_t n) {
  assert(IS_BIPART(o));
  assert(IsbPRec(o, RNamName("blocks")));

  Obj blocks_gap = ElmPRec(o, RNamName("blocks"));

  assert((size_t) LEN_LIST(blocks_gap) == 2 * n);

  std::vector<u_int32_t>* blocks(new std::vector<u_int32_t>());
  blocks->reserve(2 * n);

  for (size_t i = 0; i < 2 * n; i++) {
    blocks->push_back(INT_INTOBJ(ELM_LIST(blocks_gap, i + 1)) - 1);
  }
  return new Bipartition(blocks);
}

Obj BipartConverter::unconvert (Element* x) {
  Bipartition* xx(static_cast<Bipartition*>(x));
  
  Obj o = NEW_PLIST(T_PLIST_CYC, 2 * xx->degree());
  SET_LEN_PLIST(o, 2 * xx->degree());
  for (size_t i = 0; i < 2 * xx->degree(); i++) {
    SET_ELM_PLIST(o, i + 1, INTOBJ_INT(xx->block(i) + 1));
  }
  o = CALL_1ARGS(BipartitionByIntRepNC, o);
  return o;
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Matrices over semirings
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

MatrixOverSemiring* MatrixOverSemiringConverter::convert (Obj o, size_t n) {
  assert(IS_MAT_OVER_SEMI_RING(o));
  assert(LEN_PLIST(o) > 0);
  assert(IS_PLIST(ELM_PLIST(o, 1)));
  assert(n == (size_t) LEN_PLIST(ELM_PLIST(o, 1)));
  
  std::vector<long>* matrix(new std::vector<long>());
  matrix->reserve(n);

  for (size_t i = 0; i < n; i++) {
    Obj row = ELM_PLIST(o, i + 1);
    for (size_t j = 0; j < n; j++) {
      Obj entry = ELM_PLIST(row, j + 1);
      if (EQ(_gap_zero, entry)) {
        matrix->push_back(_semiring->zero());
      } else {
        matrix->push_back(INT_INTOBJ(entry));
      }
    }
  }
  return new MatrixOverSemiring(matrix, _semiring);
}

Obj MatrixOverSemiringConverter::unconvert (Element* x) {
  MatrixOverSemiring* xx(static_cast<MatrixOverSemiring*>(x));
  size_t n = xx->degree();
  Obj plist = NEW_PLIST(T_PLIST, n + 2);
  SET_LEN_PLIST(plist, n + 2);
  SET_ELM_PLIST(plist, n + 1, INTOBJ_INT(_semiring->threshold()));
  SET_ELM_PLIST(plist, n + 2, INTOBJ_INT(_semiring->period()));

  for (size_t i = 0; i < n; i++) {
    Obj row = NEW_PLIST(T_PLIST_CYC, n);
    SET_LEN_PLIST(row, n);
    for (size_t j = 0; j < n; j++) {
      long entry = xx->at(i * n + j);
      if (entry == _semiring->zero()) {
        SET_ELM_PLIST(row, j + 1, _gap_zero);
      } else {
        SET_ELM_PLIST(row, j + 1, INTOBJ_INT(entry));
      }
    }
    SET_ELM_PLIST(plist, i + 1, row);
    CHANGED_BAG(plist);
  }
  return CALL_2ARGS(Objectify, _gap_type, plist);
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Matrices over prime fields
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

MatrixOverSemiring* MatrixOverPrimeFieldConverter::convert (Obj o, size_t n) {
  assert(IS_MAT_OVER_PF(o));
  assert(LEN_PLIST(o) > 0);
  assert(IS_PLIST(ELM_PLIST(o, 1)));
  assert(n == (size_t) LEN_PLIST(ELM_PLIST(o, 1)));

  std::vector<long>* matrix(new std::vector<long>());
  matrix->reserve(n);

  for (size_t i = 1; i <= n; i++) {
    Obj row = ELM_PLIST(o, i);
    for (size_t j = 1; j <= n; j++) {
      matrix->push_back(VAL_FFE(ELM_PLIST(row, j)));
    }
  }
  return new MatrixOverSemiring(matrix, _semiring);
}

Obj MatrixOverPrimeFieldConverter::unconvert (Element* xx) {
  MatrixOverSemiring* x(static_cast<MatrixOverSemiring*>(xx));

  size_t n = x->degree();
  Obj plist = NEW_PLIST(T_PLIST, n);
  SET_LEN_PLIST(plist, n);

  for (size_t i = 0; i < n; i++) {
    Obj row = NEW_PLIST(T_PLIST_CYC, n);
    SET_LEN_PLIST(row, n);
    for (size_t j = 0; j < n; j++) {
      SET_ELM_PLIST(row, j + 1, INTOBJ_INT(x->at(i * n + j)));
    }
    SET_ELM_PLIST(plist, i + 1, row);
    CHANGED_BAG(plist);
  }
  PrimeField* field(static_cast<PrimeField*>(_semiring));
  return CALL_2ARGS(AsMatrixOverPrimeFieldNC, INTOBJ_INT(field->size()), plist);
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Partitioned binary relations (PBRs)
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// TODO add some more asserts here

PBR* PBRConverter::convert (Obj o, size_t n) {
  assert(IS_PBR(o));
  assert(n == (size_t) INT_INTOBJ(ELM_PLIST(o, 1)));

  std::vector<std::vector<u_int32_t> >* pbr(new std::vector<std::vector<u_int32_t> >());
  pbr->reserve(n);

  for (u_int32_t i = 0; i < 2 * n; i++) {
    Obj adj = ELM_PLIST(o, i + 2);
    std::vector<u_int32_t> next;
    for (u_int32_t j = 1; j <= LEN_PLIST(adj); j++) {
      next.push_back(INT_INTOBJ(ELM_PLIST(adj, j)) - 1);
      // assumes that adj is duplicate-free
    }
    std::sort(next.begin(), next.end());
    pbr->push_back(next);
  }
  return new PBR(pbr);
}

Obj PBRConverter::unconvert (Element* xx) {
  PBR* x(static_cast<PBR*>(xx));
  Obj plist = NEW_PLIST(T_PLIST_TAB, 2 * x->degree() + 1);
  SET_LEN_PLIST(plist, 2 * x->degree() + 1);
  SET_ELM_PLIST(plist, 1, INTOBJ_INT(x->degree()));
  for (u_int32_t i = 0; i < 2 * x->degree(); i++) {
    size_t m = x->at(i).size();
    Obj adj;
    if (m == 0) {
      adj = NEW_PLIST(T_PLIST_EMPTY, 0);
    } else {
      adj = NEW_PLIST(T_PLIST_CYC, m);
      for (size_t j = 0; j < x->at(i).size(); j++) { 
        SET_ELM_PLIST(adj, j + 1, INTOBJ_INT(x->at(i).at(j) + 1));
      }
    }
    SET_LEN_PLIST(adj, m);
    SET_ELM_PLIST(plist, i + 2, adj);
    CHANGED_BAG(plist);
  }
  return CALL_2ARGS(Objectify, PBRType, plist);
}
