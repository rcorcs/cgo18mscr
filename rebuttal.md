#Review#107A
A.1 The metric is in some ways coarse, but has a strong correlation coefficient to runtime (0.99) and mean absolute error of 3.5% (Fig3). It is enough for iterative compilation (Fig9).

A.2 We used all benchmarks in KDataSets. Some were for the cost model, the others for evaluating our methodology. This standard model
training/evaluation practice. We will make this clear in the paper.

A.3 We will publish the cost model.

#Review#107B

The paper is **not** about *reducing overhead in iterative compilation*. It is about **online** iterative compilation. We will clarify this in the paper.

B.1.Offline iterative compilation is done ahead of time in the development environment. Online iterative compilation is done *live* on users' machines. Offline requires developers to choose representative inputs, online does not. Instead, online optimization targets the actual ways users use the program. Because it is live on users' machines, inputs cannot be run twice. We will clarify this.

B.2.Online iterative compilation has **never** been done before in the general case. Some work has done online optimization where the developer provides a work or throughput metric (e.g. #requests/second assuming each request does the same work). No one has solved the general, automatic case without developer involvement. We are the first in the world to do this. Many papers have suggested it is possible. None have done it and their suggestions would not work. We will clarify this.

Yes, there has been work on input sensitivity. We agree that programs' behavior varies over inputs. That is why online iterative compilation is better, it optimizes according to the inputs the user actual presents. Input sensitive iterative compilation (via multi-versioning etc) is entirely orthogonal to online/offline. Offline requires the developer to choose representative inputs, online does not. Online input sensitive iterative compilation will match the users's inputs better. Until now, online has been impossible. We will clarify this.

The papers, Fursin etal., Ding etal., and Chen etal., are about offline iterative compilation, their approaches do not work in the online case.

That runtimes of programs with different input sets are not directly comparable is not a problem for **offline** iterative compilation, it breaks online iterative compilation. Throughput could be used, but there is no such general metric. Developers would have to provide one (e.g. #requests/second - and ensure each request comprises the same work). Our work is the first general and automatic approach.

IPC has been suggested by other papers as a possible approach to achieve online iterative compilation. None has tried it. We have shown that IPC does not work (Fig2). Our example with NOPs is only the most egregious case, to show logically why IPC is no good. In fact, it is not the cause of IPC's poor correlation in Fig2. Trading high CPI instructions for low CPI instructions (e.g. replace divide by $2^k$ with shift) also shows IPC is no good. Filtering NOPs would not fix the other cases. IPC is only good for architectural optimization. Our observation is back up by paper[17]. We will clarify this and change the example from NOPs.

Our work is not about the *overhead of replay executions*. It is about online iterative compilation where inputs cannot be repeated.

By side effects, we mean changes to external states that may not be repeated (e.g., modifying a database, file system, network activity, interacting with external third-party services). Mitigating these effects would be very cumbersome, if it is possible at all. It is different from the scenario faced by ATLAS and not about caches or noisy environments. We will clarify.

Regarding the distinction between online/offline from Fig4, please see B.1,B.2.

Regarding the shipping of the program to the iterative compilation mechanism: We only mean that the users get the program from somewhere and run it inside the iterative compilation framework. The code needs to be re-compilable, so LLVM bitcode is suitable. Application source code is not required. It is poorly worded, we will fix.

Our work is not meant only for data centers. It is generally applicable. We will clarify.

There do not need to be many alternate binaries stored. It depends on the search strategy. In the smallest case, only one binary exists at any time. Many are produced over time. We will clarify.


    For more on autotuning on the data center, see this paper from CGO16

    Dehao Chen, David Xinliang Li, and Tipp Moseley. 2016. AutoFDO: automatic feedback-directed optimization for warehouse-scale applications.

    The authors claim the proposed strategy is suitable for data center environments. But the evaluation is done on a single Intel system
    with sequential applications.

B.6
We agree that the benchmark suite used does not represent typical data center workloads. Still, we believe that our approach is perfectly suited to data center scenarios and there is no reason it would not work. In a future work, we plan to evaluate our mechanism under such an environment to better support our claim.

    The performance improvement numbers are modest. But this is probably because only 500 sequences are selected out of a possible 200
    factorial sequences in LLVM.
Yes, the performance improvements are modest. We choose a simple, repeatable, random search to allow easy comparison with other metrics. Better searches (e.g.genetic algorithms) often do much better, but the search technique is orthogonal to our work and not our focus.

    What was the basis for choosing the subset of programs from KDataSets? This needs to be clearly justified. 

Please see response to A.2 regarding benchmark partitions. 

    Minor comments:

    Speedup on X-axes made it difficult for me to interpret the results

Figure 9 reports average speedups over O3 optimization level as a % improvement whereas Figure 1 reports improvement as speedup. % improvement and speedup are not the same. We will clarify.

    Why is the Oracle-RM performing worse than other methods in some instances (e.g., qsort)?

    Section 4 has only one subsection. Consider revising. 

    page 10, line 1: correlate -> correlated

We will make all the minor corrections you suggested. Thanks for the feedback. 

#Review#107C

    Overall merit
    -------------
    2. Weak reject

    Reviewer expertise
    ------------------
    3. Knowledgeable

    Paper summary ------------- 
    The paper presents a new online iterative optimization strategy. The main new contributions of this work
    are a new work efficiency metrics that makes it possible to compare different program versions (compiled with different optimization
    sessions) across different inputs. The paper also includes an optimization of basic block profiling that is based on the idea of
    removing profiling probes if the amount of work they contribute is low but their execution count might be high.

    Comments for author
    -------------------

    I found the new efficiency metric interesting – making it possible to compare different versions of a program across different inputs
    is a novel contribution. However, some of the discussion around the efficiency metric in the paper was confusing. For example, Section
    2 states that execution time is not correlated to speedup – how is speedup exactly computed here – isn’t it based on execution time?
    Section 3 then introduces the work metrics and shows in Figure 2 that it is correlated to execution time. Earlier we established that
    execution is not correlated with speedup so does that mean the new work metric also is not correlated with speedup? The new work is
    however, positioned to approximate speedup – so these analyses are confusing – it may just be a result of the description in the paper
    but the authors should clarify.

C.1:
Thank you for the feedback, we will clarify this confusion in the paper.

In section 2, we mean that execution time alone does not correlate to the actual speedup, when we compare the program execution time obtained from different inputs, as different inputs would entail different amounts of work. In section 3, we show that work metric obtain from a given input indeed correlates with the unoptimized execution time for *the same input*, regardless of the optimization used to compile the program.  

    My main problem with the paper is that it introduces a new online iterative optimization strategy without properly evaluating it. The
    paper offers Figure 9 to show that the final optimization sequence chosen by the new online strategy reaches about 60% of the
    performance that can be achieved with offline iterative optimization.

    This evaluation doesn’t show all that much, it shows me that the proposed new strategy “has the potential to produce good results”.
    This is not enough I also need to know what it takes (i.e., the cost ) of using online optimization versus starting out with a fixed
    version that was produced with less optimally selected input in an offline iterative optimization.

    Specially, to compare online versus offline iterative optimization, I need to know the accumulated performance penalty from running
    suboptimal versions in the online setting, until I find the final optimization strategy. The authors don’t want to get into evaluating
    different search strategies – that is fine – but one could always pick a fixed search strategy that is used in both online and offline
    and then compare. To assess the potential of an online techniques I need to understand how quickly it converges or in other words how
    long the iterative optimization process continues. There is also the questions as to whether there are any advantages over offline
    iterative optimization, once the online iterative optimization sequence concludes – the actual inputs may continue to evolve .

C.2
Regarding the cost of online iterative compilation, we have focused our analysis on the profiling overhead required for guiding the search, but not the time spent on searching for the optimal version. We target scenarios where the program to be optimized will be repeatedly executed, so that the search overhead can be amortised by the improved performance. There are works on using active learning and genetic search to reduce the search overhead, which are orthogonal to our work. 

Nonetheless, we will provide results on the search overhead, and refer to those complementary techniques.

    In any realistic setting, one would want to start out with the best statically compiled version  - can this strategy provide any benefits over that scenario?  

C.3
Indeed it would interesting to investigate a search scheme that leverages from starting with the best statically compiled version of the program. However, unfortunately we do not have data for this experiment, as we assumed that -O3 would be the initial baseline. We will investigate it in the future.

    We need a comparison to offline iterative optimization to understand whether this approach is viable. 

C.4
Prior works on offline iterative compilation are all based on replays or requires the profiling to be performed on the same input. These assumptions are not suitable for the scenarios we target (see also response to B.1). We will, however, provide a comparison against offline iterative compilation. 

    The limited evaluation included is further limited by the fact that the benchmarks programs are very small and not representative of realistic datacenter applications.

C.5 Please refer to response B.6 regarding the benchmarks we used. 

#Review#107D

    Overall merit
    -------------
    2. Weak reject

    Reviewer expertise
    ------------------
    3. Knowledgeable

    Paper summary
    -------------
    Paper proposes online iterative compilation technique, which is composed of
    multiple components.
    1. Work metric to approximate performance.
    2. Relaxation methods that reduces runtime profiling overhead but penalizes
    estimation accuracy.

    Comments for author

    It is difficult to find what authors are newly contributing on top of
    existing works.
    Authors use work efficiency metric to guide optimization selection. While
    authors claim that they introduce a new "work" metric, this metric does not seem
    to be critical because "work efficiency" metric is what authors actually use to
    guide the optimization selection.
    e.g. if authors defined work efficiency as 1 / t, where t is execution time, it
    would have resulted in same conclusions.
    Although not very clear from the paper, if authors compute "work" metric
    differently for every optimization, then authors are defining the metric wrong,
    as authors highlight that work metric is defined as the amount of time taken by
    the "unoptimized" program.

D.1
Indeed, the work metric does not depend on optimizations but it does depend on the input. More input to process or more complex processing result in more work. Each measurement is done using not only a different program version but also a different input, so the work is different for each measurement. Our work efficiency metric takes this work and the runtime to calculate the amount of work done in a unit of time. Since both of them change, the work efficiency is not similar to the inverse of the runtime.

    The methods described for reducing instrument (or profiling) overhead at runtime
    are also similar to the prior works, and does not seem to contribute any
    novelty.
    In fact, many of the implementation details in the paper could just cite the
    previous work, and authors should have focused on the new parts.

D.2
We will make the contributions more explicit in section 5. As we highlight in the introduction, the main contributions regarding the profiling technique are the two relaxation strategies. Apart from the relaxation strategies, however, the optimal work profiling is not a direct implementation of the classic block-frequency profiling, thus we judged important to also describe it in more detail.

    Another problem is that there are many inconsistencies on authors' claims. For
    example, authors argue that online real inputs are important because they could
    be very different from small set of inputs given by programmer.
    However, some of the methods used by authors' do require those pre-knowledges.
    For example, whole-program relaxation requires block-frequency profiling. Since
    the instrumentation itself is done once at offline, block-frequency profiling
    must be also done before online deployment. This profiling will be again
    dependent on those small set of inputs given by programmer, which contradicts
    what authors were aiming for.

D.3
It is possible to use static heuristics for estimating block frequencies. In fact, these static heuristics are used in the results for the worst-case relaxation, where no prior profiling is required. For the whole-program profiling, however, we want to show the results for the ideal case by using actual block-frequency profiling. These block-frequency profiling can be integrated with the online framework, for example, by interleaving a sequence of executions with one that only performs the block-frequency profiling.

    Minor typos, etc:
    - Page 6, second to last paragraph:
      into the DAG An example of this is
      -> period missing between "DAG" and "An".

    - Page 9, last paragraph:
      user, by it also
      -> "by" should be "but"

