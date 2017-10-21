# Review#107A
A.1 The metric is in some ways coarse, but has a strong correlation coefficient to runtime (0.99) and a mean absolute error of 3.5% (Fig3). It is enough for iterative compilation (Fig9).

A.2 We used all benchmarks in KDataSets. Some were for the cost model, the others for evaluating our methodology. This standard model
training/evaluation practice to evaluate the generality of the model. We will make this clear in the paper.

A.3 We will publish the cost model.

# Review#107B

The paper is **not** about *reducing overhead in iterative compilation*. It is about **online** iterative compilation. We will clarify this in the paper.

B.1 Offline iterative compilation is done ahead of time in the development environment. Online iterative compilation is done *live* on users' machines. Offline requires developers to choose representative inputs, online does not. Instead, online optimization targets the actual ways users use the program. Because it is live on users' machines, inputs cannot be run twice. We will clarify this.

B.2 Online iterative compilation has **never** been done before in the general case. Some work has done online optimization where the developer provides a work or throughput metric (e.g. #requests/second assuming each request does the same work). No one has solved the general, automatic case without developer involvement. We are the first to do this. We will clarify this.

B.3 Yes, there has been work on input sensitivity. We agree that programs' behavior varies over inputs. That is why online iterative compilation is better, it optimizes according to the inputs the actual user presents. Input sensitive iterative compilation (via multi-versioning etc) is entirely orthogonal to online/offline. Online input sensitive iterative compilation will match the users's inputs better. We will clarify this.

The papers, Fursin etal., Ding etal., and Chen etal., use offline iterative compilation, their approaches do not work in the online case.

B.4 That runtimes of programs with different input sets are not directly comparable is not a problem for **offline** iterative compilation, but it breaks online iterative compilation. Throughput could be used, but there is no such general metric. Developers would have to provide one (e.g. #requests/second - and ensure each request comprises the same work). Our work is the first general and automatic approach.

IPC has been suggested by other papers as a possible approach to achieve online iterative compilation. None has tried it. We have shown that IPC does not work (Fig2). Our example with NOPs is only the most egregious case, to show logically why IPC is no good. In fact, it is not the cause of IPC's poor correlation in Fig2. Trading high CPI instructions for low CPI instructions (e.g. replace divide by $2^k$ with shift) also shows IPC is no good. Filtering NOPs would not fix the other cases. IPC is only good for architectural optimization where the program is invariant. We will clarify this and change the example from NOPs.

B.5 Our work is not about the *overhead of replay executions*. It is about online iterative compilation where inputs cannot be repeated. See also B.1 and B.2.

B.6 By side effects, we mean changes to external states that may not be repeated (e.g., modifying a database, file system, network activity, interacting with external third-party services). Mitigating these effects would be very cumbersome, if it is possible at all. It is different from the scenario faced by ATLAS and not about caches or noisy environments. We will clarify.

B.7 Regarding the distinction between online/offline from Fig4, please see B.1 and B.2.

B.8 Regarding the shipping of the program to the iterative compilation mechanism: We only mean that the users get the program from somewhere and run it inside the iterative compilation framework. The code needs to be re-compilable, so LLVM bitcode is suitable. Application source code is not required. It is poorly worded, we will fix.

B.9 Our work is not meant only for data centers. It is generally applicable. We will clarify.

B.10 There do not need to be many alternate binaries stored. It depends on the search strategy. In the smallest case, only one binary exists at any time. Many are produced over time. We will clarify.
    
B.11 The AutoFDO paper is not about iterative compilation. It repeatedly profiles and feeds profiles to an FDO compiler, but this is not iterative compilation search (despite a section with that title) -- theirs has no search for performance efficiency. We will discuss in related work.

B.12 Yes, our evaluation was not done in a data center. However, it is entirely general and should work from mobile systems to data centers. We did not mean to suggest that we had evaluated it in all domains. We will clarify.

B.13 Yes, the performance improvements are modest because of the small, random search. We chose it to allow easy comparison with other metrics. Better searches (e.g.genetic algorithms) often do much better, but the search technique is orthogonal to our work and not our focus.

B.14 Please see response to A.2 regarding benchmark partitions. 

B.15 Figure 9 reports average speedups over O3 optimization level as a % improvement whereas Figure 1 reports improvement as speedup. % improvement and speedup are not the same. We will clarify.

B.16 Regarding Oracle-RM performing worse than other methods, these measurements are within the noise floor.  We will increase the run count to get statistically significant comparisons.


# Review#107C

C.1 Thank you for the feedback, we will clarify this confusion in the paper.

In Section 2 we mean that execution time does not correlate to efficiency unless all inputs have the same work. We will reword.

In Section 3 we show the work metric correlates with unoptimized execution time for *the same input*, regardless of optimization. We will clarify.

C.2 We think you are asking for a "total lifetime cost", i.e. including costs of poorly performing program versions in the search. This is a very good idea which we did not think of. However, random search is ill-suited for this, a well designed GA would be better. We were not considering the search itself as interesting. We will show total lifetime cost, and in the future apply better search.

C.3 Starting with the best statically compiled version is a very good idea. We don't know the quantitive benefit. We will consider this in future work when improving the search technique.

C.4 We do compare offline iterative compilation, OracleRM, it runs each input twice per optimization. Our approach is gets close to this.

C.5 Regarding benchmarks not being for data centers, please see B.9.

# Review#107D

D.1 For novelty, please see B.2.

D.2 Yes, work efficiency is the metric. It is work/time. Time is easy, we need a work metric.

**HJL rewrite - lists of different sizes**
If work efficiency were $1/t$: consider comparing efficiency of two sorting algorithms this way. If program A sorts a 2 element list and program B sorts a million, $t_A<t_B$ but we do not know which is more efficient. We will clarify in the paper.

Our work metric does not change because of the optimization. We will clarify.

D.3 The only similarity in our work is to classic block-frequency profiling. We extend with relaxation which is entirely novel. We will rebalance the writing.

D.4 The profiling that drives the whole program relaxation is done *online* - by profiling the first few inputs (not programmer provided). It could be periodically updated. We regard this as somewhat orthogonal. No pre-knowledge is required. We will clarify.

D.5 Thank for catching the typos.
