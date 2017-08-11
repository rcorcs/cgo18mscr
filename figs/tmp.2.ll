; ModuleID = 'tmp.bc'
source_filename = "tmp.ll"

define i32 @odd_inc_stack(i32 %arg) {
entry:
  %rem = srem i32 %arg, 2
  %cmp = icmp eq i32 %rem, 0
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %add.1 = add i32 %arg, 1
  br label %if.end

if.else:                                          ; preds = %entry
  %add.2 = add i32 %arg, 2
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %addr.0 = phi i32 [ %add.1, %if.then ], [ %add.2, %if.else ]
  ret i32 %addr.0
}
