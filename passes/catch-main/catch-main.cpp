#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/Pass.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Support/raw_ostream.h"
#include <iostream>
#include <vector>

using namespace llvm;
using namespace std;

namespace
{

struct CatchMain : public ModulePass
{
	static char ID;
	CatchMain() : ModulePass(ID) {}

	void getAnalysisUsage(AnalysisUsage &analysisUsage) const override
	{
		analysisUsage.addRequired<LoopInfoWrapperPass>();
		analysisUsage.setPreservesAll();
	}

	bool runOnModule(Module &module) override
	{
		for (auto &func : module)
		{
			if (func.isDeclaration())
				continue;
			if (func.getName() == "main")
			{
				cout << "1\n";
				return false;
			}
		}
		cout << "0\n";
		return false;
	}
};
} // namespace

char CatchMain::ID = 0;
static RegisterPass<CatchMain> X("catch-main", "Count the number of nested loops in the program");