-- tcc-816 code optimizer
-- /Mic, 2010
--
-- Based on the forthec code optimizer 
-- /Mic, 2008

without warning
include parser.e

constant tccregs = {"tcc__r0","tcc__r1","tcc__r5"}

constant conds_816 = {"cc","cs","eq"}

        
-- Enumerators used in optimisation patterns
global constant COND = -2,
         NUMRANGE = -3,
         LESSBITSSET = -4,
         ISPOW2 = -5
         
         
         
constant patterns_816 = {
{
	{
	"lda.w #/imm/",
	"sta.b tcc__r0",
	"lda.w #/imm/",
	"sta.b tcc__r9",
	"lda.w #/imm/",
	"sta.b tcc__r9h",
	"sep #$20",
	"lda.b tcc__r0",
	"sta.b [tcc__r9]",
	"rep #$20"
	},
	{
	1,
	7,
	{"sta.l %(^3*#65536+^2)"},
	10
	}
},
{
	{
	"lda.w #/imm/",
	"sta.b tcc__r9",
	"lda.w #/imm/",
	"sta.b tcc__r9h",
	"sep #$20",
	"lda.b tcc__r0",
	"sta.b [tcc__r9]",
	"rep #$20"
	},
	{
	5,
	6,
	{"sta.l %(^2*#65536+^1)"},
	8
	}
},
{
	{
	"stz.b tcc__r0",
	"lda.w #/imm/",
	"sta.b tcc__r9",
	"lda.w #/imm/",
	"sta.b tcc__r9h",
	"sep #$20",
	"lda.b tcc__r0",
	"sta.b [tcc__r9]",
	"rep #$20"
	},
	{
	1,
	6,
	{"lda #0"},
	{"sta.l %(^2*#65536+^1)"},
	9
	}
},
{
	{
	"lda /imm/ + /label/ + 1,s",
	"sta.b tcc__r0h",
	"lda /imm/ + /label/ + 1,s",
	"sta.b tcc__r0",
	"sta -/imm/ + /label/ + 1,s",
	"lda.b tcc__r0h",
	"sta -/imm/ + /label/ + 1,s"
	},
	{
	1,
	7,
	3,
	5
	}
},	
{
	{
	"stz.b tcc__r0",
	"lda.b tcc__r0",
	"sta -/imm/ + /label/ + 1,s",
	"/label/",
	"lda -/imm/ + /label/ + 1,s",
	"sta.b tcc__r0"
	},
	{
	{"lda #0"},
	3,
	4,
	5,
	6
	}
},
{
	{
	"ldx #1",
	"lda.b tcc__r0",
	"sec",
	"sbc #/imm/",
	"tay",
	"beq +",
	"dex",
	"+",
	"stx.b tcc__r5",
	"txa",
	"bne +",
	"brl /label/",
	"+"
	},
	{
	2,
	{"cmp #^1"},
	{"beq +"},
	12,
	13
	}
},
{
	{
	"ldx #1",
	"sec",
	"sbc #/imm/",
	"tay",
	"beq +",
	"dex",
	"+",
	"stx.b tcc__r5",
	"txa",
	"bne +",
	"brl /label/",
	"+"
	},
	{
	{"cmp #^1"},
	{"beq +"},
	11,
	12
	}
},

{
	{
	"ldx #1",
	"lda.b tcc__r0",
	"sec",
	"sbc.b tcc__r1",
	"tay",
	"beq +",
	"bcs ++",
	"+ dex",
	"++",
	"stx.b tcc__r5",
	"txa",
	"bne +",
	"brl /label/",
	"+"
	},
	{
	2,
	{"cmp.b tcc__r1"},
	{"beq +"},
	{"bcc +"},
	{"brl ++"},
	{"+"},
	{"brl ^1"},
	{"++"}
	}
},


{
	{
	"ldx #1",
	"sec",
	"sbc.w #/imm/",
	"tay",
	"bvc +",
	"eor #$8000",
	"+",
	"bmi +++",
	"++",
	"dex",
	"+++",
	"stx.b tcc__r5",
	"txa",
	"bne +",
	"brl /label/",
	"+"
	},
	{
	{"cmp #^1"},
	{"bvc +"},
	{"ora #$8000"},
	{"+"},
	{"bmi +"},
	{"brl ^2"},
	{"+"}
	}
},
{
	{
	"ldx #1",
	"lda.b /tccreg/",
	"sec",
	"sbc.b /tccreg/",
	"tay",
	"bvc +",
	"eor #$8000",
	"+",
	"bmi +++",
	"++",
	"dex",
	"+++",
	"stx.b tcc__r5",
	"txa",
	"bne +",
	"brl /label/",
	"+"
	},
	{
	{"lda.b ^1"},
	{"cmp.b ^2"},
	{"bvc +"},
	{"ora #$8000"},
	{"+"},
	{"bmi +"},
	{"brl ^3"},
	{"+"}
	}
},
{
	{
	"ldx #1",
	"sec",
	"sbc.b /tccreg/",
	"tay",
	"bvc +",
	"eor #$8000",
	"+",
	"bmi +++",
	"++",
	"dex",
	"+++",
	"stx.b tcc__r5",
	"txa",
	"bne +",
	"brl /label/",
	"+"
	},
	{
	{"cmp.b ^1"},
	{"bvc +"},
	{"ora #$8000"},
	{"+"},
	{"bmi +"},
	{"brl ^2"},
	{"+"}
	}
},

{
	{
	"rep #$20",
	"sep #$20"
	},
	{
	2
	}
},
{
	{
	"sep #$20",
	"rep #$20"
	},
	{
	2
	}
},

{
	{
	"sta.b tcc__r0",
	"lda.w #/imm/",
	"sta.b tcc__r9",
	"stz.b tcc__r9h",
	"lda.b tcc__r0",
	"sta.b [tcc__r9]"
	},
	{
	1,
	{"sta.l ^1"}
	}
},
{
	{
	{"lda -/imm/ + /label/ + 1,s","lda /imm/ + /label/ + 1,s"},
	"sta.b tcc__r0",
	"sta.b tcc__r1",
	"lda.b tcc__r0h",
	"sta.b tcc__r1h",
	"inc.b tcc__r0",
	"lda.b tcc__r0",
	{"sta -/imm/ + /label/ + 1,s","sta /imm/ + /label/ + 1,s"}
	},
	{
	1,
	3,
	{"ina"},
	2,
	8,
	4,
	5
	}
},
{
	{
	"lda.w #0",
	"sep #$20",
	"lda.b [tcc__r0]",
	"rep #$20",
	"cmp #$8000",
	"ror a",
	"cmp #$8000",
	"ror a",
	"cmp #$8000",
	"ror a",
	"cmp #$8000",
	"ror a"
	},
	{
	1,
	2,
	3,
	{"lsr a"},
	{"lsr a"},
	{"lsr a"},
	{"lsr a"},
	{"rep #$20"}
	}
},
{
	{
	{"lda -/imm/ + /label/ + 1,s","lda /imm/ + /label/ + 1,s"},
	"sta.b tcc__r0",
	"sta.b tcc__r1",
	"inc.b tcc__r0",
	"lda.b tcc__r0",
	{"sta -/imm/ + /label/ + 1,s","sta /imm/ + /label/ + 1,s"}
	},
	{
	1,
	3,
	{"ina"},
	2,
	6
	}
},
{
	{
	"lda /imm/ + /label/ + 1,s",
	"sta.b tcc__r0",
	"sta.b tcc__r1",
	"lda.b tcc__r0h",
	"sta.b tcc__r1h",
	"dec.b tcc__r0",
	"lda.b tcc__r0",
	"sta /imm/ + /label/ + 1,s"
	},
	{
	1,
	3,
	{"dea"},
	2,
	8,
	4,
	5
	}
},
{
	{
	"ldx #1",
	"sec",
	"sbc.w #/imm/",
	"tay",
	"beq ++",
	"bvc +",
	"eor #$8000",
	"+",
	"bpl +++",
	"++",
	"dex",
	"+++",
	"stx.b tcc__r5",
	"txa",
	"bne +",
	"brl /label/",
	"+"
	},
	{
	{"cmp #^1"},
	{"beq ++"},
	{"bvc +"},
	{"ora #$8000"},
	{"+"},
	{"bpl +"},
	{"++"},
	{"brl ^2"},
	{"+"}
	}
},
{
	{
	"ldx #1",
	"lda.b tcc__r0",
	"sec",
	"sbc.b tcc__r1",
	"tay",
	"b/cond/ ++",
	"+ dex",
	"++",
	"stx.b tcc__r5",
	"txa",
	"bne +",
	"/label/",
	"brl /label/",
	"+"
	},
	{
	2,
	{"cmp.b tcc__r1"},
	{"b^1 +"},
	12,
	{"brl ^3"},
	{"+"}
	}
},
{
	{
	"ldx #1",
	"lda.b tcc__r0",
	"sec",
	"sbc.b tcc__r1",
	"tay",
	"b/cond/ ++",
	"+ dex",
	"++",
	"stx.b tcc__r5",
	"txa",
	"bne +",
	"brl /label/",
	"+"
	},
	{
	2,
	{"cmp.b tcc__r1"},
	{"b^1 +"},
	{"brl ^2"},
	{"+"}
	}
},
{
	{
	"ldx #1",
	"sec",
	"sbc.w #/imm/",
	"tay",
	"bcs ++",
	"+ dex",
	"++",
	"stx.b tcc__r5",
	"txa",
	"bne +",
	"brl /label/",
	"+"
	},
	{
	{"cmp.w #^1"},
	{"bcs +"},
	{"brl ^2"},
	{"+"}
	}
},

{
	{
	"sep #$20",
	{"lda.l /label/", "lda.l /label/ + /imm/"},
	"rep #$20",
	"xba",
	"xba",
	"bpl +",
	"ora.w #$ff00",
	"+"
	},
	{
	1,
	2,
	3,
	6,
	7,
	8
	}
},
{
	{
	"clc",
	"lda.b /tccreg/",
	"adc.w #65535"
	},
	{
	2,
	{"dea"}
	}
},
{
	{
	"clc",
	{"lda.l /label/", "lda.l /label/ + /imm/"},
	"adc.w #65535"
	},
	{
	2,
	{"dea"}
	}
},
{
	{
	"lda.w /label/ + /imm/",
	"clc",
	"adc.w #/imm/",
	"asl a",
	"sta.b tcc__r0",
	"lda.w #:/label/",
	"sta.b tcc__r1h",
	"lda.w #/label/ + /imm/",
	"clc",
	"adc.b tcc__r0",
	"sta.b tcc__r1",
	"lda.b [tcc__r1]"
	},
	{
	1,
	2,
	3,
	4,
	{"tax"},
	{"lda.l ^4+^6,x"}
	}
},
{
	{
	"lda /imm/ + /label/ + /imm/,s",
	"asl a",
	"sta.b tcc__r0",
	"lda.w #:/label/",
	"sta.b tcc__r1h",
	"lda.w #/label/ + /imm/",
	"clc",
	"adc.b tcc__r0",
	"sta.b tcc__r1",
	"lda.b [tcc__r1]"
	},
	{
	1,
	2,
	{"tax"},
	{"lda.l ^4+^6,x"}
	}
},
{
	{
	"lda.w /label/ + /imm/",
	"asl a",
	"sta.b tcc__r0",
	"lda.w #:/label/",
	"sta.b tcc__r1h",
	"lda.w #/label/ + /imm/",
	"clc",
	"adc.b tcc__r0",
	"sta.b tcc__r1",
	"lda.b [tcc__r1]"
	},
	{
	1,
	2,
	{"tax"},
	{"lda.l ^3+^5,x"}
	}
},
{
	{
	"ldy.w #/imm/",
	"-",
	"asl a",
	"dey",
	"bne -"
	},
	{
	{COND,NUMRANGE,1,2,6,0,"ldy.w #^1"},
	{COND,NUMRANGE,1,2,6,0,"-"},
	{COND,NUMRANGE,1,2,6,0,"asl a"},
	{COND,NUMRANGE,1,2,6,0,"dey"},
	{COND,NUMRANGE,1,2,6,0,"bne -"},
	{COND,NUMRANGE,1,2,6,1, "asl a"},
	{COND,NUMRANGE,1,2,6,1, "asl a"},
	{COND,NUMRANGE,1,3,6,1, "asl a"},
	{COND,NUMRANGE,1,4,6,1, "asl a"},
	{COND,NUMRANGE,1,5,6,1, "asl a"},
	{COND,NUMRANGE,1,6,6,1, "asl a"}
	}
},


{
	{
	"and.w #/imm/",
	"and.w #/imm/"
	},
	{
	{"and #%(^1&^2)"}
	}
}

}


	
-- Global variables         
global integer
	ifs,		-- If-counter
	cases,		-- Case-counter
	loops,		-- Loop-counter
	calls,	
	outfile,
	usesI,		-- Does the current loop use I ?
	usesConsole,	-- Does the program use the console (x86) ?
	usesCR, usesLF,	
	usesLoops,
	usesFP,
	usesIP,
	usesDict,	-- Does the program use the dictionary ?
	usesMiscS,
	usesCase,	-- Does the program use any Cases ?
	usesPrint,
	usesDiv,	-- Does the program use divisions ?
	useRegs,
	allowInline,	-- Allow word inlining (1) or not (0)
	inline,		-- Inline the current word (1) or not (0)
	strops,		-- String operations flag
	ignoreOutput,	-- Used to ignore output of unreferenced/inlined words
	globLit,
	noMangle,	-- Mangle word names (0) or not (1)
	noFold,		-- Fold constant expressions (0) or not (1)
	p1,p2,
	dllentry,
	rangeIdx,

	fastfloat

global sequence
	code,		-- Contains the generated code of user-defined words
	maincode,	-- Contains the generated code of the main program
	inlinecode,	-- Contains the generated code of the current inlined word
	inlines,	-- Contains the generated code of all inlined words
	deferred,
	referred,	-- Hold reference counts for user-defined words
	ifStack,	-- Used for handling stacked If-constructs
	literals,
	immliterals,
	includes,
	labelPrefix,
	publics,
	CMD,
	pendingWordDef,	-- Hold info about the currently processed word definition
	userWords,	-- Associative array containing info about user-defined words
	variables,	-- Associative array containing info about user-defined variables
	regs,
	rstack,
	fastCmp

global integer
	linesRemoved,	-- Number of lines removed by the optimiser
	constRemoved,	-- Number of constants removed
	optLevel	-- Optimisation level
	
global sequence
	patvars,	-- Pattern variables (set by the pattern comparator in the optimiser)
	constlist
	

global sequence
	cfgin,
	morefiles,
	outname,
	entry,
	fentry,
	nofpu
	
global integer
	cfgfile,
	dll,
	infpos
	
global atom
	t1,
	iwramStart,
	iwramEnd,
	ewramStart,
	ewramEnd



-- Initialise common variables
global procedure optimore_init()
	code = {}
	ifStack = {}
	maincode = {}
	deferred = {{},{}}
	publics = {{},{}}
	literals = {}
	immliterals = {{},{}}
	pendingWordDef = {}
	tokens = {}
	userWords = {{},{}}
	constants = {{},{}}
	fconstants = {{},{}}
	variables = {{},{}}
	inlinecode = {}
	inlines = {}
	errors = {{},{}}
	
	inline = 0
	allowInline = 1
	noMangle = 0
	noFold = 0
	errorCount = 0
	ignoreOutput = 0
	linesRemoved = 0
	constRemoved = 0
	constlist = {}	
end procedure


-- Return "name.ext" as {"name","ext"}
global function cut_filename(sequence fname)
	integer p
	
	p = length(fname)
	while p>=1 do
		if fname[p] = '.' then
			exit
		end if
		p -= 1
	end while

	if p then
		return {fname[1..p-1],fname[p+1..length(fname)]}
	end if
	
	return fname
end function



-- Mangle label names
global function make_label(sequence id)
	sequence s

	if noMangle then
		return id
	end if
	
	s = ""
	for i=1 to length(id) do
		s &= "%02x"
	end for
	
	return labelPrefix&"lbl_"&sprintf(s,id)
end function



-- Counts set bits
global function count_bits(atom a)
	atom msk
	integer cnt

	
	msk = 1

	cnt = 0
	for i=1 to 32 do
		if and_bits(a,msk) then
			cnt += 1
		end if
		msk += msk
	end for
	return cnt
end function


-- Add a sequence of code to the current output
global procedure ADD_CODE(sequence instr,integer section)
	if not ignoreOutput then
		if length(pendingWordDef) then
			code &= instr
		else
			maincode &= instr
		end if
	elsif inline then
		inlinecode &= instr	
	end if
end procedure



-- Return the length of the current output
global function get_code_length()
	if inline then
		return length(inlinecode)
	end if
	if length(pendingWordDef) then
		return length(code)
	end if
	return length(maincode)
end function



-- Remove all code from position i1..i2 in the current output
global procedure REMOVE_CODE(integer i1,integer i2)
	if not ignoreOutput then
		if length(pendingWordDef) then
			code = code[1..i1-1]&code[i2+1..length(code)]
		else
			maincode = maincode[1..i1-1]&maincode[i2+1..length(maincode)]
		end if
	elsif inline then
		inlinecode = inlinecode[1..i1-1]&inlinecode[i2+1..length(inlinecode)]
	end if
end procedure



-- Count the number of references to all IDs (UNKNOWN tokens) in the program
-- The minimum reference count is 1, since its declaration is counted as well
global procedure count_refs()
	integer n

	referred = {{},{}}
	for i=1 to length(tokens) do
		if tokens[i][1] = UNKNOWN then
			n = bsearch(tokens[i][2],referred[1])
			if n>0 then
				referred[2][n][1] += 1
			else
				referred = assoc_insert(tokens[i][2],{1},referred)
			end if
		end if
	end for
end procedure



								


function compare_patterns_816(sequence s1,sequence s2)
	integer eql,p1,p2,m,n,o
	sequence s3,s4
	
	eql = 1
	p1 = 1
	p2 = 1
	m = length(patvars)
	o = 0
	
	
	while eql do
		if p1>length(s1) or
		   p2>length(s2) then
			exit
		end if
		if s2[p2] = '/' then
			s3 = {}
			p2 += 1
			while s2[p2] != '/' do
				s3 &= s2[p2]
				p2 += 1
			end while
			p2 += 1
			
			s4 = {}
			while p1<=length(s1) do
				if s1[p1]=',' or
				   s1[p1]=']' or
				   s1[p1]=' ' or
				   s1[p1]=')' then
					exit
				end if
				s4 &= s1[p1]
				p1 += 1
			end while
			
			if equal(s3,"tccreg") then
				if find(s4,tccregs) then
					patvars = append(patvars,s4)
				else
					eql = 0
					exit
				end if

			elsif equal(s3,"const") then
				--s4 &= ']'
				eql = 0
				if find('_',s4) and length(s4)>=6 then
					if equal("const_",s4[1..6]) then
						eql = 1
						--p1 += 1
						patvars = append(patvars,s4)
					end if
				end if
			elsif equal(s3,"var") then
				--s4 &= ']'
				eql = 0
				if find('_',s4) then
					if equal("var_",s4[1..4]) then
						eql = 1
						--p1 += 1
						patvars = append(patvars,s4)
					end if
				end if
			--elsif equal(s3,"ind") then
			--	s4 &= ']'
			--	eql = 0
			--	if length(s4)>12 then
			--		if equal("dword ptr [e",s4[1..12]) then
			--			eql = 1
			--			p1 += 1
			--			patvars = append(patvars,s4)
			--		end if
			--	end if
			--elsif equal(s3,"qlit") then
			--	s4 &= ']'
			--	eql = 0
			--	if find('_',s4) then
			--		if equal("qword ptr [lit_",s4[1..15]) then
			--			eql = 1
			--			p1 += 1
			--			patvars = append(patvars,s4)
			--		end if
			--	end if
			elsif equal(s3,"imm") then
				o = 0
				--if length(s4)>6 then
				--	if equal(s4[1..6],"offset") then
				--		patvars = append(patvars,s4)
				--		o = 1
				--	end if
				--end if
				if o=0 then
					s3 = value(s4)
					if s3[1]=GET_SUCCESS and integer(s3[2]) then
						patvars = append(patvars,s4)
					else
						eql = 0
					end if
				end if
			elsif equal(s3,"cond") then
				if find(' ',s4) then
					p1 -= length(s4)+1-find(' ',s4)
					--puts(1,"s1[p1] = "&s1[p1]&"\n")
					s4 = s4[1..find(' ',s4)-1]
				end if
				if find(s4,conds_816) then
					patvars = append(patvars,s4)
					--puts(1,s4&"*\n")
				else
					eql = 0
				end if
			elsif equal(s3,"label") then
				if s4[1]='_' or (s4[1] >= 'A' and s4[1] <= 'Z') or (s4[1] >= 'a' and s4[1] <= 'z') then
					--if s4[1] = 'g' then
					--	puts(1, s4&"\n")
					--end if
					patvars = append(patvars,s4)
				else
					eql = 0
				end if
			elsif equal(s3,"if") then
				if s4[1]='_' then
					patvars = append(patvars,s4)
				else
					eql = 0
				end if				

			end if
			
		elsif s2[p2]='^' then
			n = 0
			p2 += 1
			while p2<=length(s2) do
				if s2[p2]>='0' and s2[p2]<='9' then
					n = n*10 + s2[p2]-'0'
				else
					exit
				end if
				p2 += 1
			end while
			s3 = patvars[n]

			s4 = {}
			while p1<=length(s1) do
				if s1[p1]=',' or
				   s1[p1]=']' then
				   	if s1[p1]=']' then p1+=1 end if
					exit
				end if
				s4 &= s1[p1]
				p1 += 1
			end while
			if length(s4)>11 then
				if equal(s4[7..9],"ptr") then
					s4 &= ']'
				end if
			end if
			
			if not equal(s3,s4) then
				if s3[1]='_' then
					if not equal(s3&':',s4) then
						eql = 0
					end if
				else
					eql = 0
				end if
			end if
				
		else
			if s1[p1]!=s2[p2] then
				eql = 0
			end if
			p1 += 1
			p2 += 1
		end if
	end while
	
	if p1<length(s1) or p2<length(s2) then
		eql = 0
	end if
	
	if not eql then
		if m=0 then
			patvars = {}
		else
			patvars = patvars[1..m]
		end if
	end if
	
	return eql
end function



function pattern_append_816(sequence s1,sequence s2)
	integer p2,m,n,oper,expval
	sequence s3,s4,ops

	p2 = 1
	s3 = {}
	while 1 do
		if p2>length(s2) then
			exit
		end if
		
		if s2[p2]='^' then
			n = 0
			p2 += 1
			while p2<=length(s2) do
				if s2[p2]>='0' and s2[p2]<='9' then
					n = n*10 + s2[p2]-'0'
				else
					exit
				end if
				p2 += 1
			end while
			s3 &= patvars[n]
		elsif s2[p2]='%' then
			p2 += 2
			expval = 0
			ops = {}
			oper = 0
			while s2[p2] != ')' do
				if s2[p2] = '^' or
				   s2[p2] = '#' then
				   	m = s2[p2]
					n = 0
					p2 += 1
					while p2<=length(s2) do
						if s2[p2]>='0' and s2[p2]<='9' then
							n = n*10 + s2[p2]-'0'
						else
							exit
						end if
						p2 += 1
					end while
					if m='^' then
						s4 = value(patvars[n])
					else
						s4 = {GET_SUCCESS,n}
					end if
					if oper=0 then
						expval = s4[2]
					elsif oper='+' then
						expval += s4[2]
					elsif oper='-' then
						expval -= s4[2]
					elsif oper='/' then
						expval = floor(expval/s4[2])
					elsif oper='\\' then
						expval = remainder(expval,s4[2])
					elsif oper='*' then
						expval *= s4[2]
					elsif oper='&' then
						expval = and_bits(expval,s4[2])
					elsif oper='|' then
						expval = or_bits(expval,s4[2])
					elsif oper='?' then
						expval = xor_bits(expval,s4[2])
					end if

				elsif s2[p2] = '+' then
					oper = s2[p2]
					p2 += 1
				elsif s2[p2] = '*' then
					oper = s2[p2]
					p2 += 1
				elsif s2[p2] = '/' then
					oper = s2[p2]
					p2 += 1
				elsif s2[p2] = '\\' then
					oper = s2[p2]
					p2 += 1
				elsif s2[p2] = '-' then
					oper = s2[p2]
					p2 += 1
				elsif s2[p2] = '&' then
					oper = s2[p2]
					p2 += 1
				elsif s2[p2] = '|' then
					oper = s2[p2]
					p2 += 1
				else
					p2 += 1
				end if
			end while
			p2 += 1
			s3 &= sprintf("%d",expval)
					
		else
			s3 &= s2[p2]
			p2 += 1
		end if
	end while
	
	return append(s1,s3)
end function




function pattern_optimise_816(sequence subject,sequence patterns,integer maxIterations)
	integer i1,i2,i3,i4,p,q,n,m,o,clean,improvement,times,reachable,newlen
	sequence s,r,t,u,pat

	while maxIterations>0 do
		improvement = linesRemoved

		-- Replace common instruction patterns by more compact forms
		p = 1
		while p<=length(subject) do
			for i=1 to length(patterns) do
				pat = patterns[i]
				if p+length(pat[1])<=length(subject)+1 then
					patvars = {}
					n = 1
					for j=1 to length(pat[1]) do

						if sequence(pat[1][j][1]) then
							m = 0
							for k=1 to length(pat[1][j]) do
								if compare_patterns_816(subject[p+j-1],pat[1][j][k]) then
									m = k
									exit
								end if
							end for
							if not m then
								n = 0
								exit
							end if
						else
							if not compare_patterns_816(subject[p+j-1],pat[1][j]) then
								n = 0
								exit
							end if
						end if
					end for

					-- Was a matching pattern found ?
					if n then
						if i=9999 then 
							if equal(patvars[1],patvars[2]) then
								linesRemoved += 5
								subject = subject[1..p-1] & subject[p+5..length(subject)]
							else
								linesRemoved += 4
								subject = subject[1..p-1] & {"b "&patvars[3]} & subject[p+5..length(subject)]
							end if
						else
							s = {}
							newlen = 0
							for j=1 to length(pat[2]) do
								if sequence(pat[2][j]) then
									if sequence(pat[2][j][1]) then
										s = pattern_append_816(s,pat[2][j][1])
										newlen += 1
									else
										if pat[2][j][1] = COND then
											if pat[2][j][2] = NUMRANGE then
												t = value(patvars[pat[2][j][3]])
												if t[2]>=pat[2][j][4] and t[2]<=pat[2][j][5] and pat[2][j][6] then
													s = pattern_append_816(s,pat[2][j][7])
													newlen += 1
												elsif (not (t[2]>=pat[2][j][4] and t[2]<=pat[2][j][5])) and pat[2][j][6]=0 then
													s = pattern_append_816(s,pat[2][j][7])
													newlen += 1
												end if
											elsif pat[2][j][2] = LESSBITSSET then
												t = value(patvars[pat[2][j][3]])
												u = value(patvars[pat[2][j][4]])
												if count_bits(t[2]) < count_bits(u[2]) and pat[2][j][6] then
													s = pattern_append_816(s,pat[2][j][7])
													newlen += 1
												elsif count_bits(t[2])>=count_bits(u[2]) and pat[2][j][6]=0 then
													s = pattern_append_816(s,pat[2][j][7])
													newlen += 1
												end if
											end if

										else
											s = pattern_append_816(s,subject[p+pat[2][j][1]-1][pat[2][j][2]..pat[2][j][3]]&pat[2][j][4])
											newlen += 1
										end if
									end if
								else
									s = pattern_append_816(s,subject[p+pat[2][j]-1])
									newlen += 1
								end if
							end for
							subject = subject[1..p-1] & s & subject[p+length(pat[1])..length(subject)]
							linesRemoved += length(pat[1])-newlen --length(pat[2])
						end if
						exit
					end if
				end if
			end for
			p += 1
		end while


		-- Stop when there's nothing more to optimise
		improvement -= linesRemoved
		if not improvement then
			exit
		end if
		maxIterations -= 1
	end while
		

	return subject
end function





global function optimise_816(sequence subject,integer remConst)
	integer i1,i2,i3,i4,p,q,n,m,o,clean,improvement,times,reachable
	sequence s,r,t,u,pat
	integer regsAreFree,isInnermost

	i1 = 0
	i2 = 0
	i3 = 0
	m = 0
	n = 0
	o = 0
	p = 0
	q = 0
	improvement = 0
	
	if remConst and 0 then
		-- Remove unused constants
		for i=1 to length(constants[2]) do
			if constants[2][i][2]=0 then
				--subject = subject[1..constants[2][i][3]-1] & {"add esp,4"} & subject[constants[2][i][3]+2..length(subject)]
				--constRemoved += 1
				--for j=i+1 to length(constants[2]) do
				--	if constants[2][j][3]>constants[2][i][3] then
				--		constants[2][j][3] -= 1
				--	end if
				--end for
			end if
		end for
	end if


	if optLevel >= 5 and 0 then
		if remConst then
			constlist = {}
			for i=1 to length(subject) do
				patvars = {}
				--if compare_patterns_z80(subject[i],"ldr r1,/const/") then
				--	if equal(subject[i+1],"str r0,[r1]") then
				--		constlist = append(constlist,patvars&{i,1,1})
				--	elsif equal(subject[i+1],"str r2,[r1]") then
				--		constlist = append(constlist,patvars&{i,2,1})
				--	end if
				--end if
			end for
		end if

	end if		
	
	
	-- Run up to 10 passes
	subject = pattern_optimise_816(subject, patterns_816, 10)

	
	return subject
end function



optimore_init()
optLevel = 6


CMD = command_line()
constant infile = open(CMD[3], "rb")
if infile = -1 then
	puts(1, "Error: unable to open "& CMD[3] & "\n")
	abort(1)
end if

sequence s
integer c
s = ""

while 1 do
	c = getc(infile)
	if c = -1 then exit end if
	if c = 10 then
		if length(s) then
			maincode = append(maincode, s)
			s = ""
		end if
	elsif c != 13 then
		s &= c
	end if
end while
if length(s) then
	maincode = append(maincode, s)
end if
close(infile)

s = optimise_816(maincode, 0)
outfile = open(CMD[4], "wb")
if outfile = -1 then
	puts(1, "Error: unable to create "& CMD[4] & "\n")
	abort(1)
end if

for i = 1 to length(s) do
	puts(outfile, s[i] & {13,10})
end for

close(outfile)

printf(1,"Done! %d lines removed.\n", linesRemoved)


