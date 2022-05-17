#include <iostream>
#include <stdlib.h>
#include <algorithm>
#include <vector>
using namespace std;

#define UNDEF -1
#define TRUE 1
#define FALSE 0

int numVars;
int numClauses;


/**
 * Clàusules del problema
 * Cada clausula té 3 literals
 * Cada literal pot ser positiu o negatiu, i de valors entre 1 i numVars
 */
vector<vector<int> > clauses;

/**
 * Mida fixa a numVars(+1)
 * Estat del model en construcció. Els possibles estats son:
 * - UNDEF: encara no s'ha tractat
 * - TRUE: s'està utilitzant en positiu
 * - FALSE: s'està utilitzant en negatiu
 */
vector<int> model; //solució en progress, cada literal té UNDEF, TRUE o FALSE

/**
 * Stack(mida varaible)
 * Guarda els literals que s'han decidit o propagat des de l'inici del programa.
 * Per guardar les posicions dels decisions levels, s'insereix un 0 com a marca.
 */
vector<int> modelStack;

/**
 * Apuntador del modelStack, guarda quins elements de l'stack encara s'han
 * de propagar
 */
uint indexOfNextLitToPropagate;

/**
 * Quantes decisions s'han fet fins al moment??
 */
uint decisionLevel;

//només serveix de moment per la propagació
vector< vector<bool> > OL; //per cada literal (SENSE SIGNE) a quines clausules apareix

//?? de moment no es fa servir
vector<int> SOL; //per cada literal (positius i negatius) quantes vegades apareix a alguna clausula


/* ---------- OTHER ---------- */


int abs(int n) {
  if(n >= 0) return n;
  else return -n;
}


/* ---------- INPUT ---------- */


/**
 * @brief      
 * Reads clauses from .cnf file. Updates numVars, numClauses and clauses[][]
 */
void readClauses(){
  // Skip comments
  char c = cin.get();
  while (c == 'c') {
    while (c != '\n') c = cin.get();
    c = cin.get();
  }  
  // Read "cnf numVars numClauses"
  string aux;
  cin >> aux >> numVars >> numClauses;
  clauses.resize(numClauses);  
  // Read clauses
  for (uint i = 0; i < numClauses; ++i) {
    int lit;
    while (cin >> lit and lit != 0) clauses[i].push_back(lit);
  }    
}

/* SET & GET */


/**
 * @brief      Per consultar el valor d'un literal al model en construcció
 *
 * @param[in]  lit   El literal(amb signe o sense)
 *
 * @return     Si el literal no està tractat o si s'ha escollit positiu o negatiu
 */
int currentValueInModel(int lit){
  if (lit >= 0) return model[lit];
  else {
    if (model[-lit] == UNDEF) return UNDEF;
    else return 1 - model[-lit];
  }
}

/**
 * @brief      Es defineix un literal a cert en el model en construcció i s'afegeix al modelstack també.
 *
 * @param[in]  lit   Literal
 */
void setLiteral(int lit){
  modelStack.push_back(lit);
  if (lit > 0) model[lit] = TRUE;
  else model[-lit] = FALSE;   
}


/**
 * @brief      Prints SOL and OL variables in standard output.
 */
void printOL() {
  cout << "SOL vector:" << endl;
  for(int i = 0; i < SOL.size(); i++) {
    if(i < numVars) cout << i - numVars << "\t";
    else cout << i - numVars +1 << "\t";
  }
  cout << endl;
  for(int i = 0; i < SOL.size(); i++) cout << SOL[i] << "\t";
  cout << endl << endl << "OL MATRIX:" << endl;
  for(int i = 0; i < OL.size(); i++) {
    for(int j = 0; j < OL[i].size(); j++) cout << OL[i][j] << ", ";
    cout << endl;
  }
  cout << endl;
}

/*
 * Fer el setup de les occurs lists de manera eficient 
 */
void OLSetup() {
  //inicialitzar variables globals
  vector< vector<bool> > aux(numVars+1, vector<bool>(numClauses,false));
  //vector<int> auxs(numVars+1,0);
  OL = aux;
  //SOL = auxs;

  //afegir contingut inicial
  for(int clause = 0; clause < numClauses; clause++) {
    for(int lit = 0; lit < clauses[clause].size(); lit++) {
      OL[abs(clauses[clause][lit])][clause] = true;
      //SOL[] s'ha de mirar
    }
  }
  //printOL();
}


/* ---------- CHECKING  ---------- */

/**
 * @brief      Serveix per un cop s'ha acabat de calcular, comprovar si és SAT o INSAT
 *
 * @return     20 if SAT, 10 if INSAT
 */
void checkmodel(){
  for (uint i = 0; i < numClauses; ++i){
    bool someTrue = false;
    for (uint j = 0; not someTrue and j < clauses[i].size(); ++j)
      someTrue = (currentValueInModel(clauses[i][j]) == TRUE);
    if (not someTrue) {
      cout << "Error in model, clause is not satisfied:";
      for (uint j = 0; j < clauses[i].size(); ++j) cout << clauses[i][j] << " ";
      cout << endl;
      exit(1);
    }
  }  
}




bool propagateGivesConflict ( ) {
  while ( indexOfNextLitToPropagate < modelStack.size() ) {
    
    int lit = abs(modelStack[indexOfNextLitToPropagate]);
    // cout << "----" << endl;
    // cout << "index: "<< indexOfNextLitToPropagate << " " << endl;
    // cout << "stack size:" <<  modelStack.size() << " " << endl;
    // cout << "lit: " << modelStack[indexOfNextLitToPropagate] << " " << endl;

    for(int i = 0; i < numClauses; ++i) {
      if(OL[lit][i]) {
        bool someLitTrue = false;
        int numUndefs = 0;
        int lastLitUndef = 0;
        for (uint k = 0; not someLitTrue and k < clauses[i].size(); ++k) {
          int val = currentValueInModel(clauses[i][k]);
          if (val == TRUE) someLitTrue = true;
          else if (val == UNDEF) {
            ++numUndefs;
            lastLitUndef = clauses[i][k];
          }
        }
        if (not someLitTrue and numUndefs == 0) return true; // conflict! all lits false
        else if (not someLitTrue and numUndefs == 1) setLiteral(lastLitUndef);  
      }
    }

    // S'abança una vegada l'index, marcant una propagació feta
    ++indexOfNextLitToPropagate;
  }
  return false;
}


void backtrack(){
  uint i = modelStack.size() -1;
  int lit = 0;
  while (modelStack[i] != 0){ // 0 is the DL mark
    lit = modelStack[i];
    model[abs(lit)] = UNDEF;
    modelStack.pop_back();
    --i;
  }
  // at this point, lit is the last decision
  modelStack.pop_back(); // remove the DL mark
  --decisionLevel;
  indexOfNextLitToPropagate = modelStack.size();
  setLiteral(-lit);  // reverse last decision
}


/*
 * Canviar l'heurística perquè seleccioni els estats dels literals que
 * generenin més propagacions/conflictes
 */

/**
 * @brief      Fa una decisió sobre el següent literal a agafar.
 *
 * @return     Següent literal.
 * 
 * VERSIÓ 0: Retrona un literal [1,numVars] sense signe
 * VERSIÓ 1: ...
 */
int getNextDecisionLiteral(){
  for (uint i = 1; i <= numVars; ++i) // stupid heuristic:
    if (model[i] == UNDEF) return i;  // returns first UNDEF var, positively
  return 0; // reurns 0 when all literals are defined
}


int main(){ 
  readClauses(); // reads numVars, numClauses and clauses
  model.resize(numVars+1,UNDEF);
  indexOfNextLitToPropagate = 0;  
  decisionLevel = 0;

  OLSetup();
  
  // Take care of initial unit clauses, if any
  for (uint i = 0; i < numClauses; ++i)
    if (clauses[i].size() == 1) {
      int lit = clauses[i][0];
      int val = currentValueInModel(lit);
      if (val == FALSE) {cout << "UNSATISFIABLE" << endl; return 10;}
      else if (val == UNDEF) setLiteral(lit);
    }
  
  // DPLL algorithm
  while (true) {
    //PROPAGACIÓ
    while ( propagateGivesConflict() ) {
      // Si hi ha un conflicte amb nivell de decisió 0 és que és INSAT i s'acaba el programa
      if ( decisionLevel == 0) { cout << "UNSATISFIABLE" << endl; return 10; }

      //BACKTRACK
      backtrack();
    }

    //DECISIÓ
    int decisionLit = getNextDecisionLiteral();

    // Si ja s'han decidit tots els literals i no es pot fer backtrack s'acaba el programa
    if (decisionLit == 0) { checkmodel(); cout << "SATISFIABLE" << endl; return 20; }

    // Es guarda la nova decisió:
    // Nova marca de nivell de decisió (valor a 0)
    // Incrementar decisionLevel, IndexOfNextLitToPropagate
    // Afegir a l'stack decisionLit i també posar-lo a true al model
    // El indexONLTP acaba estant un enrrere del modelStack, per propagar una vegada com a mínim
    modelStack.push_back(0);
    ++indexOfNextLitToPropagate;
    ++decisionLevel;
    setLiteral(decisionLit);
  }
}  
