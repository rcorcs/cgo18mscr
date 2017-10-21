# Review#107A
A.1.The metric is coarse, but has a strong correlation coefficient to runtime (0.99) and a mean absolute error of 3.5% (Figure.3). It is enough for iterative compilation (Figure.9).

A.2.We used all KDataSets benchmarks: some are for the cost model, others for methodology evaluation. This is standard model
training/evaluation practice to evaluate the generality of the model. We will clarify.

A.3.We will publish the cost model.

# Review#107B

The paper is **not** about *reducing overhead in iterative compilation*. It is about **online** iterative compilation. We will clarify in the paper.

B.1.Offline iterative compilation happens ahead-of-time in the development environment. Online iterative compilation is done *live* on users' machines. Offline requires developers to choose representative inputs, online does not. Instead, online optimization targets the actual user inputs. Being live on users' machines, inputs cannot run twice. We will clarify.

B.2.Online iterative compilation has **never** been done before in the general case. Some work has done online optimization where the developer provides a work or throughput metric (e.g. #requests/second assuming each request does the same work). No one has solved the general, automatic case without developer involvement. We are the first to do this. We will clarify.

B.3.Yes, there is work on input sensitivity. We agree, programs' behavior varies over inputs. That is why online iterative compilation is better, it optimizes according to actual user inputs. Input-sensitive iterative compilation (via multi-versioning etc) is entirely orthogonal to online/offline. Online input-sensitive iterative compilation will match the users's inputs better. We will clarify.

The papers, Fursin etal.,Ding etal.,and Chen etal., use offline iterative compilation, they do not handle the online case.

B.4.That runtimes on different inputs are incomparable is okay for **offline** iterative compilation, but breaks online iterative compilation. Throughput could be used, but developers would have to define it (e.g. #requests/second - and ensure work/request uniformity). Ours is the first general, automatic approach.

Other papers suggested IPC for online iterative compilation. None has tried it. We show that IPC fails (Figure.2). Our NOPs example is the most egregious case, showing why IPC is no good. It is not the cause of IPC's poor correlation in Figure.2. Trading high CPI instructions for low CPI instructions (e.g. replace divide by $2^k$ with shift) also shows IPC is no good. Filtering NOPs would not fix the other cases. IPC is good for architectural optimization with invariant programs. We will clarify and change the example from NOPs.

B.5.Our work is not about the *overhead of replay executions*. It is about online iterative compilation where inputs are unrepeatable. See B.1-B.2.

B.6.By side effects, we mean unrepeatable changes to external states (e.g., database modification, file modification, network activity, calling external third-party services). Mitigating these would be hard or impossible. It is different from ATLAS' scenario and not about caches or noisy environments. We will clarify.

B.7.Regarding the distinction between online/offline from Figure.4, please see B.1-B.2.

B.8.Regarding shipping the program to the iterative compilation mechanism: We only mean that program is run inside the iterative compilation framework. It is poorly worded, we will fix. The code must be re-compilable, so LLVM bitcode is suitable. Application source-code is not required. 

B.9.Our work is not data-centers specific. It is generally applicable. We will clarify.

B.10.Storing many alternate binaries is unnecessary. It is search strategy dependent. In ours, one binary exists at any time. We will clarify.
    
B.11.AutoFDO is not about iterative compilation. It repeatedly feeds profiles to a FDO compiler. That is not iterative compilation search (despite such a section title)--they have no search. We will discuss in related work.

B.12.Yes, we did not evaluate on data-centers. We meant it is general from mobile systems to data-centers. We did not mean to suggest that we evaluated in all domains. We will clarify.

B.13.Yes, performance improvements are modest because of the small, random search. We chose it for easy comparison with other metrics. Better searches (e.g. GAs) do much better. This is orthogonal to our work and not our focus.

B.14.See A.2 regarding benchmark partitions. 

B.15.Figure.9 reports average speedups over -O3 as a %-improvement whereas Figure.1 reports improvement as speedup. %-improvement and speedup are not the same. We will clarify.

B.16.Regarding Oracle-RM performing worse, these measurements are within the noise floor.  We will run more for statistically significant comparisons.


# Review#107C

C.1.Thank you for the feedback, we will clarify confusion in the paper.

In Section 2 we mean that execution time does not correlate to efficiency unless all inputs have the same work. We will reword.

In Section 3 we show the work metric correlates with unoptimized execution time for *the same input*, regardless of optimization. We will clarify.

C.2.Regarding "total lifetime cost", i.e. costs of poorly performing program versions in the search. This is a good idea, thank-you. However, random search is ill-suited for this, unlike a well designed GA. We were not considering the search interesting. We will show total lifetime cost, and in future apply better search.

C.3.Starting with the best statically compiled version is a good idea. We don't know the quantitive benefit. We will consider this in future work when improving the search.

C.4.We do compare offline iterative compilation; OracleRM runs each input twice per optimization. Our online approach gets close.

C.5.Regarding benchmarks for data-centers, please see B.9-B.12.

# Review#107D

D.1.For novelty, please see B.2.

D.2.Yes, work efficiency is the metric. It is work/time. Time is easy, we need a work metric.

If work efficiency were $1/t$: consider comparing efficiency of sorting algorithms this way.If programs, A and B sort lists of different sizes, $t_A<t_B$ does not say which is more efficient. We will clarify.

Our work metric does not change because of the optimization. We will clarify.

D.3.The only similarity in our work is to classic block-frequency profiling. We extend with relaxation which is entirely novel. We will rebalance the writing.

D.4.The profiling that drives the whole program relaxation is done *online* - by profiling the first few inputs (not programmer provided). It could be periodically updated. We regard this as somewhat orthogonal. No pre-knowledge is required. We will clarify.

D.5.Thanks for typos.
