define i32 @odd_inc_stack(i32 %arg) {
entry:
  %addr = alloca i32
  %rem = srem i32 %arg, 2
  %cmp = icmp eq i32 %rem, 0
  br i1 %cmp, label %if.then, label %if.else
if.then:
  %add.1 = add i32 %arg, 1
  store i32 %add.1, i32* %addr
  br label %if.end
if.else:
  %add.2 = add i32 %arg, 2
  store i32 %add.2, i32* %addr
  br label %if.end
if.end:
  %ans = load i32, i32* %addr
  ret i32 %ans
}
