`include "header.vh"

module divide_replace(
    input clk,
    input rst,
    input[10:0] val_out3,
    output[7:0] val_out4
    );
	
	function inbetween(input [10:0] low, value, high); 
	begin
		inbetween = value >= low && value <= high;
	end
	endfunction

	
	
	reg[7:0]	val_out4;

	always@(posedge clk, posedge rst)
	begin
	if(rst) begin
		val_out4	<= 0;
	end else begin
	case (1)
		inbetween(63,val_out3,192): val_out4  <= 255;
		inbetween(193,val_out3,193): val_out4 <= 198 ;
		inbetween(194,val_out3,194): val_out4 <= 197 ;
		inbetween(195,val_out3,195): val_out4 <= 196 ;
		inbetween(196,val_out3,196): val_out4 <= 195 ;
		inbetween(197,val_out3,197): val_out4 <= 194 ;
		inbetween(198,val_out3,198): val_out4 <= 193 ;
		inbetween(199,val_out3,200): val_out4 <= 192 ;
		inbetween(201,val_out3,201): val_out4 <= 191 ;
		inbetween(202,val_out3,202): val_out4 <= 190 ;
		inbetween(203,val_out3,203): val_out4 <= 189 ;
		inbetween(204,val_out3,204): val_out4 <= 188 ;
		inbetween(205,val_out3,205): val_out4 <= 187 ;
		inbetween(206,val_out3,206): val_out4 <= 186 ;
		inbetween(207,val_out3,207): val_out4 <= 185 ;
		inbetween(208,val_out3,208): val_out4 <= 184 ;
		inbetween(209,val_out3,209): val_out4 <= 183 ;
		inbetween(210,val_out3,210): val_out4 <= 182 ;
		inbetween(211,val_out3,212): val_out4 <= 181 ;
		inbetween(213,val_out3,213): val_out4 <= 180 ;
		inbetween(214,val_out3,214): val_out4 <= 179 ;
		inbetween(215,val_out3,215): val_out4 <= 178 ;
		inbetween(216,val_out3,216): val_out4 <= 177 ;
		inbetween(217,val_out3,218): val_out4 <= 176 ;
		inbetween(219,val_out3,219): val_out4 <= 175 ;
		inbetween(220,val_out3,220): val_out4 <= 174 ;
		inbetween(221,val_out3,221): val_out4 <= 173 ;
		inbetween(222,val_out3,223): val_out4 <= 172 ;
		inbetween(224,val_out3,224): val_out4 <= 171 ;
		inbetween(225,val_out3,225): val_out4 <= 170 ;
		inbetween(226,val_out3,227): val_out4 <= 169 ;
		inbetween(228,val_out3,228): val_out4 <= 168 ;
		inbetween(229,val_out3,229): val_out4 <= 167 ;
		inbetween(230,val_out3,231): val_out4 <= 166 ;
		inbetween(232,val_out3,232): val_out4 <= 165 ;
		inbetween(233,val_out3,234): val_out4 <= 164 ;
		inbetween(235,val_out3,235): val_out4 <= 163 ;
		inbetween(236,val_out3,237): val_out4 <= 162 ;
		inbetween(238,val_out3,238): val_out4 <= 161 ;
		inbetween(239,val_out3,240): val_out4 <= 160 ;
		inbetween(241,val_out3,241): val_out4 <= 159 ;
		inbetween(242,val_out3,243): val_out4 <= 158 ;
		inbetween(244,val_out3,244): val_out4 <= 157 ;
		inbetween(245,val_out3,246): val_out4 <= 156 ;
		inbetween(247,val_out3,247): val_out4 <= 155 ;
		inbetween(248,val_out3,249): val_out4 <= 154 ;
		inbetween(250,val_out3,250): val_out4 <= 153 ;
		inbetween(251,val_out3,252): val_out4 <= 152 ;
		inbetween(253,val_out3,254): val_out4 <= 151 ;
		inbetween(255,val_out3,256): val_out4 <= 150 ;
		inbetween(257,val_out3,257): val_out4 <= 149 ;
		inbetween(258,val_out3,259): val_out4 <= 148 ;
		inbetween(260,val_out3,261): val_out4 <= 147 ;
		inbetween(262,val_out3,263): val_out4 <= 146 ;
		inbetween(264,val_out3,264): val_out4 <= 145 ;
		inbetween(265,val_out3,266): val_out4 <= 144 ;
		inbetween(267,val_out3,268): val_out4 <= 143 ;
		inbetween(269,val_out3,270): val_out4 <= 142 ;
		inbetween(271,val_out3,272): val_out4 <= 141 ;
		inbetween(273,val_out3,274): val_out4 <= 140 ;
		inbetween(275,val_out3,276): val_out4 <= 139 ;
		inbetween(277,val_out3,278): val_out4 <= 138 ;
		inbetween(279,val_out3,280): val_out4 <= 137 ;
		inbetween(281,val_out3,282): val_out4 <= 136 ;
		inbetween(283,val_out3,284): val_out4 <= 135 ;
		inbetween(285,val_out3,286): val_out4 <= 134 ;
		inbetween(287,val_out3,288): val_out4 <= 133 ;
		inbetween(289,val_out3,290): val_out4 <= 132 ;
		inbetween(291,val_out3,293): val_out4 <= 131 ;
		inbetween(294,val_out3,295): val_out4 <= 130 ;
		inbetween(296,val_out3,297): val_out4 <= 129 ;
		inbetween(298,val_out3,300): val_out4 <= 128 ;
		inbetween(301,val_out3,302): val_out4 <= 127 ;
		inbetween(303,val_out3,304): val_out4 <= 126 ;
		inbetween(305,val_out3,307): val_out4 <= 125 ;
		inbetween(308,val_out3,309): val_out4 <= 124 ;
		inbetween(310,val_out3,312): val_out4 <= 123 ;
		inbetween(313,val_out3,314): val_out4 <= 122 ;
		inbetween(315,val_out3,317): val_out4 <= 121 ;
		inbetween(318,val_out3,320): val_out4 <= 120 ;
		inbetween(321,val_out3,322): val_out4 <= 119 ;
		inbetween(323,val_out3,325): val_out4 <= 118 ;
		inbetween(326,val_out3,328): val_out4 <= 117 ;
		inbetween(329,val_out3,331): val_out4 <= 116 ;
		inbetween(332,val_out3,333): val_out4 <= 115 ;
		inbetween(334,val_out3,336): val_out4 <= 114 ;
		inbetween(337,val_out3,339): val_out4 <= 113 ;
		inbetween(340,val_out3,342): val_out4 <= 112 ;
		inbetween(343,val_out3,345): val_out4 <= 111 ;
		inbetween(346,val_out3,349): val_out4 <= 110 ;
		inbetween(350,val_out3,352): val_out4 <= 109 ;
		inbetween(353,val_out3,355): val_out4 <= 108 ;
		inbetween(356,val_out3,358): val_out4 <= 107 ;
		inbetween(359,val_out3,362): val_out4 <= 106 ;
		inbetween(363,val_out3,365): val_out4 <= 105 ;
		inbetween(366,val_out3,369): val_out4 <= 104 ;
		inbetween(370,val_out3,372): val_out4 <= 103 ;
		inbetween(373,val_out3,376): val_out4 <= 102 ;
		inbetween(377,val_out3,380): val_out4 <= 101 ;
		inbetween(381,val_out3,384): val_out4 <= 100 ;
		inbetween(385,val_out3,387): val_out4 <= 99 ;
		inbetween(388,val_out3,391): val_out4 <= 98 ;
		inbetween(392,val_out3,395): val_out4 <= 97 ;
		inbetween(396,val_out3,400): val_out4 <= 96 ;
		inbetween(401,val_out3,404): val_out4 <= 95 ;
		inbetween(405,val_out3,408): val_out4 <= 94 ;
		inbetween(409,val_out3,412): val_out4 <= 93 ;
		inbetween(413,val_out3,417): val_out4 <= 92 ;
		inbetween(418,val_out3,421): val_out4 <= 91 ;
		inbetween(422,val_out3,426): val_out4 <= 90 ;
		inbetween(427,val_out3,431): val_out4 <= 89 ;
		inbetween(432,val_out3,436): val_out4 <= 88 ;
		inbetween(437,val_out3,441): val_out4 <= 87 ;
		inbetween(442,val_out3,446): val_out4 <= 86 ;
		inbetween(447,val_out3,451): val_out4 <= 85 ;
		inbetween(452,val_out3,457): val_out4 <= 84 ;
		inbetween(458,val_out3,462): val_out4 <= 83 ;
		inbetween(463,val_out3,468): val_out4 <= 82 ;
		inbetween(469,val_out3,474): val_out4 <= 81 ;
		inbetween(475,val_out3,480): val_out4 <= 80 ;
		inbetween(481,val_out3,486): val_out4 <= 79 ;
		inbetween(487,val_out3,492): val_out4 <= 78 ;
		inbetween(493,val_out3,498): val_out4 <= 77 ;
		inbetween(499,val_out3,505): val_out4 <= 76 ;
		inbetween(506,val_out3,512): val_out4 <= 75 ;
		inbetween(513,val_out3,518): val_out4 <= 74 ;
		inbetween(519,val_out3,526): val_out4 <= 73 ;
		inbetween(527,val_out3,533): val_out4 <= 72 ;
		inbetween(534,val_out3,540): val_out4 <= 71 ;
		inbetween(541,val_out3,548): val_out4 <= 70 ;
		inbetween(549,val_out3,556): val_out4 <= 69 ;
		inbetween(557,val_out3,564): val_out4 <= 68 ;
		inbetween(565,val_out3,573): val_out4 <= 67 ;
		inbetween(574,val_out3,581): val_out4 <= 66 ;
		inbetween(582,val_out3,590): val_out4 <= 65 ;
		inbetween(591,val_out3,600): val_out4 <= 64 ;
		inbetween(601,val_out3,609): val_out4 <= 63 ;
		inbetween(610,val_out3,619): val_out4 <= 62 ;
		inbetween(620,val_out3,629): val_out4 <= 61 ;
		inbetween(630,val_out3,640): val_out4 <= 60 ;
		inbetween(641,val_out3,650): val_out4 <= 59 ;
		inbetween(651,val_out3,662): val_out4 <= 58 ;
		inbetween(663,val_out3,673): val_out4 <= 57 ;
		inbetween(674,val_out3,685): val_out4 <= 56 ;
		inbetween(686,val_out3,698): val_out4 <= 55 ;
		inbetween(699,val_out3,711): val_out4 <= 54 ;
		inbetween(712,val_out3,724): val_out4 <= 53 ;
		inbetween(725,val_out3,738): val_out4 <= 52 ;
		inbetween(739,val_out3,752): val_out4 <= 51 ;
		inbetween(753,val_out3,768): val_out4 <= 50 ;
		inbetween(769,val_out3,783): val_out4 <= 49 ;
		inbetween(784,val_out3,800): val_out4 <= 48 ;
		inbetween(801,val_out3,817): val_out4 <= 47 ;
		inbetween(818,val_out3,834): val_out4 <= 46 ;
		inbetween(835,val_out3,853): val_out4 <= 45 ;
		inbetween(854,val_out3,872): val_out4 <= 44 ;
		inbetween(873,val_out3,893): val_out4 <= 43 ;
		inbetween(894,val_out3,914): val_out4 <= 42 ;
		inbetween(915,val_out3,936): val_out4 <= 41 ;
		inbetween(937,val_out3,960): val_out4 <= 40 ;
		inbetween(961,val_out3,984): val_out4 <= 39 ;
		inbetween(985,val_out3,1010): val_out4 <= 38 ;
		inbetween(1011,val_out3,1037): val_out4 <= 37 ;
		inbetween(1038,val_out3,1066): val_out4 <= 36 ;
		inbetween(1067,val_out3,1097): val_out4 <= 35 ;
		inbetween(1098,val_out3,1129): val_out4 <= 34 ;
		inbetween(1130,val_out3,1163): val_out4 <= 33 ;
		inbetween(1164,val_out3,1200): val_out4 <= 32 ;
		inbetween(1201,val_out3,1238): val_out4 <= 31 ;
		inbetween(1239,val_out3,1250): val_out4 <= 30 ;
		default:								 val_out4 <= 255;
	endcase
	end
	end



endmodule
