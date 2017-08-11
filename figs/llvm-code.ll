
define i32 @odd_inc(i32 %arg) {
entry:
  %rem = srem i32 %arg, 2
  %cmp = icmp eq i32 %rem, 0
  br i1 %cmp, label %if.then, label %if.else
if.then:
  %add.1 = add nsw i32 10, 1
  br label %if.end
if.else:
  %add.2 = add nsw i32 10, 2
  br label %if.end
if.end:
  %ans = phi i32 [ %add.1, %if.then ], [ %add.2, %if.else ]
  ret i32 %ans
}
