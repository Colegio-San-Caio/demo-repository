code=open('stage2.asm').read()
code=code.replace('je.empty','je.empty').replace('je.done','je.done').replace('je.eq','je.eq').replace('jne.ne','jne.ne').replace('jmp.l','jmp.l').replace('jnz.next','jnz.next').replace('jmp.loop','jmp.loop').replace('je.loop','je.loop').replace('jmp.shell','jmp shell').replace('je.back','je.back').replace('jae.loop','jae.loop').replace('jb.loop','jb.loop')
# also fix double dots
code=code.replace('jmp..','jmp.')
open('stage2.asm','w').write(code)
print('fixed')
