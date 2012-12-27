-----####PetDate.lua 1.43####
-------1.43:修复之前导致的错误品质切换错误

local _,k,v
--- Globals
local _G = getfenv(0)
local hooksecurefunc, tinsert, pairs, wipe = _G.hooksecurefunc, _G.table.insert, _G.pairs, _G.wipe
local ipairs = _G.ipairs
local L = HPetLocals

HPetDate={
[39]={8.5,7.5,8,{11,21}},
[40]={7,8.5,8.5,{8,18}},
[41]={7,8.5,8.5,{4}},
[42]={6.5,9,8.5,{7}},
[43]={7,9,8,{3,13}},
[44]={7,8.5,8.5,{5,15}},
[45]={7,8.5,8.5,{3}},
[46]={7.5,7.5,9,{12,22}},
[47]={8,7.5,8.5,{3,5,13,15}},
[49]={9,7,8,{3}},
[50]={9,8,7,{11,21}},
[51]={8.5,8,7.5,{3,5,13,15}},
[52]={8,8,8,{13,20,21,22}},
[55]={8.5,7,8.5,{3,5,6,9,13,15,16,19}},
[56]={8.5,9,6.5,{18}},
[57]={8.5,7.5,8,{4}},
[58]={7,9,8,{8,18}},
[59]={8.5,8,7.5,{19}},
[64]={8.5,7.5,8,{9}},
[65]={8.5,7.5,8,{12,22}},
[67]={8,8,8,{3,8,10,13,18,20}},
[68]={8,8,8,{3,6,7,13,16,17}},
[69]={7.5,7.5,9,{3,10,11,13,20,21}},
[70]={8,7.5,8.5,{3,5,12,13,15,22}},
[72]={8,7,9,{3,5,11,13,15,21}},
[74]={7.5,7.5,9,{11,21}},
[75]={7.5,8.5,8,{5,15}},
[77]={8,8,8,{3,13}},
[78]={7.5,8.5,8,{12,22}},
[83]={8.5,7.5,8,{18}},
[84]={8,8,8,{13,20,21,22}},
[85]={8.5,7.5,8,{9}},
[86]={8.5,7.5,8,{7}},
[87]={8,8.5,7.5,{5}},
[89]={8,8,8,{6}},
[90]={7,8.5,8.5,{17}},
[92]={8,8,8,{3}},
[93]={6.5,9,8.5,{4}},
[94]={7,7,10,{5}},
[95]={8,8,8,{3}},
[106]={8.5,7.5,8,{10}},
[107]={8,8,8,{3}},
[111]={8,8,8,{12}},
[114]={8.5,8.5,7,{12}},
[116]={8,8,8,{12}},
[117]={8,8,8,{3}},
[118]={8,8,8,{3}},
[119]={8,8,8,{3}},
[120]={8,8,8,{13}},
[121]={8,8,8,{13}},
[122]={8,8,8,{5}},
[124]={8,8,8,{3}},
[125]={8,8,8,{5}},
[126]={8,8,8,{10}},
[127]={8,7.5,8.5,{7}},
[128]={8,8,8,{3}},
[130]={8,8,8,{3}},
[131]={8,7.5,8.5,{8}},
[132]={9,8,7,{6}},
[136]={8,8,8,{3,7,10,12,13,17,20,22}},
[137]={8,7,9,{3,5,11,13,15,21}},
[138]={8.5,7.5,8,{3,12,13,22}},
[139]={7.5,8.5,8,{3,8,12,13,18,22}},
[140]={8,8.5,7.5,{3,4,12,13,14,22}},
[141]={7.5,7.5,9,{3,6,12,13,16,22}},
[142]={8,8.5,7.5,{3,5,13,15}},
[143]={7.5,8.5,8,{3,5,8,13,15,18}},
[144]={7.5,7.5,9,{3,5,11,13,15,21}},
[145]={8.5,7.5,8,{3,5,6,8,13,15,16,18}},
[146]={7.5,8,8.5,{3,5,9,12}},
[149]={7.5,7,9.5,{9}},
[153]={8,8,8,{7}},
[155]={8,8,8,{7}},
[156]={8,8,8,{3}},
[157]={8,8,8,{3}},
[158]={8,8,8,{3}},
[159]={8,8,8,{16}},
[160]={8,8,8,{4}},
[162]={8,8.5,7.5,{10}},
[163]={8,8.5,7.5,{8}},
[164]={8,8.5,7.5,{3}},
[165]={8.5,7.5,8,{9}},
[166]={8.5,8.5,7,{7}},
[167]={9,7.5,7.5,{3,6,9,13,16,19}},
[168]={8.5,7.5,8,{15}},
[170]={8,8,8,{7}},
[171]={8,8,8,{7}},
[172]={7.5,8.5,8,{10}},
[173]={8,8.5,7.5,{7}},
[174]={8,8.5,7.5,{3}},
[175]={7.5,8.5,8,{5}},
[179]={8.5,8,7.5,{7}},
[180]={8.5,8,7.5,{7}},
[183]={8,8,8,{3}},
[186]={7.5,8.5,8,{3,4,5,8,13,14,15,18}},
[187]={8.5,8.5,7,{8}},
[188]={8.5,8.5,7,{6}},
[189]={8,8,8,{3}},
[190]={8.5,8.5,7,{6,7,12}},
[191]={8.5,7.5,8,{3}},
[192]={8,8,8,{9}},
[193]={8,8.5,7.5,{4}},
[194]={8,8,8,{3,5,8,9,11,13,15,18,19,21}},
[195]={7.5,7.5,9,{5,8,9,11,15,18,19,21}},
[196]={8.5,8,7.5,{7}},
[197]={7.5,8,8.5,{8}},
[198]={8,8,8,{11}},
[199]={8,8,8,{10}},
[200]={8,7,9,{15}},
[201]={8,8,8,{7}},
[202]={8,8,8,{7}},
[203]={8,7,9,{22}},
[204]={8,8,8,{3}},
[205]={8,8,8,{7}},
[206]={8.5,8.5,7,{3,9,11,13,19,21}},
[207]={8,8,8,{8,18}},
[209]={8,8,8,{3,13}},
[210]={8,8,8,{5}},
[211]={8.5,8,7.5,{6}},
[212]={8,8,8,{3}},
[213]={8,8,8,{5}},
[215]={8.5,7.5,8,{10,20}},
[217]={8,8,8,{7}},
[218]={8.5,7.5,8,{4}},
[220]={8,8,8,{9}},
[224]={7,8.5,8.5,{10,20}},
[225]={8,8,8,{3}},
[226]={8,8,8,{4}},
[227]={8,8,8,{4}},
[228]={8,8,8,{7}},
[229]={8,8,8,{3}},
[231]={8.5,8,7.5,{3}},
[232]={7,8.5,8.5,{8}},
[233]={7,8.5,8.5,{18}},
[234]={7,8.5,8.5,{10}},
[235]={7,8.5,8.5,{20}},
[236]={7.5,8.5,8,{6,16}},
[237]={7,8.5,8.5,{3}},
[238]={7,8.5,8.5,{21}},
[239]={8,8,8,{14}},
[240]={8.5,8.5,7,{3}},
[242]={7.5,8.5,8,{8}},
[243]={9,9,6,{20}},
[244]={8.5,9,6.5,{7}},
[245]={8,8,8,{8}},
[246]={8,8,8,{3}},
[247]={8,8,8,{6}},
[248]={8,8,8,{8}},
[249]={8.5,8.5,7,{7}},
[250]={7.5,9,7.5,{8}},
[251]={8.5,8.5,7,{3}},
[253]={8,8,8,{3}},
[254]={8,8,8,{3,5,8,13,15,18}},
[255]={7.5,9,7.5,{6}},
[256]={8,9,7,{7}},
[258]={8.5,9,6.5,{6}},
[259]={8.5,7.5,8,{12}},
[260]={8,8.5,7.5,{8}},
[261]={8.5,7.5,8,{4}},
[262]={8.5,7.5,8,{5}},
[264]={8.5,8.5,7,{8}},
[265]={9.5,8,6.5,{6}},
[266]={8.5,8.5,7,{18}},
[267]={8,8,8,{3}},
[268]={8.5,9,6.5,{4}},
[270]={8.5,8.5,7,{9}},
[271]={8,7.5,8.5,{3,9,10,13,19,20}},
[272]={9,7.5,7.5,{6,9,16,19}},
[277]={8.5,7.5,8,{11}},
[278]={8,8,8,{9}},
[279]={8,8,8,{8}},
[285]={8,9,7,{10}},
[286]={9,8,7,{7}},
[287]={8,7.5,8.5,{3}},
[289]={9.5,8.5,6,{6}},
[291]={9,7.5,7.5,{22}},
[292]={8,8,8,{3}},
[293]={8,8,8,{9}},
[294]={8,8,8,{8}},
[296]={8,8,8,{3}},
[297]={8,9.5,6.5,{4}},
[298]={8,8,8,{3}},
[301]={7,8.5,8.5,{11}},
[302]={8.5,8.5,7,{7}},
[303]={7,8.5,8.5,{15}},
[306]={7,8.5,8.5,{21}},
[307]={8,8,8,{3}},
[308]={8,8,8,{3}},
[309]={6.5,9,8.5,{18}},
[310]={8,8,8,{8}},
[311]={8.5,8,7.5,{3}},
[316]={8.5,7.5,8,{3}},
[317]={8.5,8.5,7,{3}},
[318]={7.5,8.5,8,{3}},
[319]={6.5,9,8.5,{20}},
[320]={8.5,7.5,8,{17}},
[321]={8,8,8,{6}},
[323]={8,8,8,{8}},
[325]={7.5,9,7.5,{5,8,10,15,18,20}},
[328]={8,8,8,{4}},
[329]={8,8,8,{8}},
[330]={8,8,8,{10}},
[333]={8,8,8,{11}},
[335]={9,7.5,7.5,{12}},
[337]={8,8,8,{12}},
[338]={8.5,7.5,8,{7}},
[339]={8,8,8,{12}},
[340]={8,8,8,{13}},
[341]={8,8,8,{3}},
[342]={8,8,8,{3}},
[343]={7,8.5,8.5,{3,8,13,18}},
[346]={8,8,8,{3}},
[347]={8,8.75,7.25,{3}},
[348]={8.5,8.5,7,{8}},
[374]={8,8,8,{7,8,9,10,11,12,17,18,19,20,21,22}},
[378]={8,7,9,{3,5,7,9,11,12,13,17,19,21,22}},
[379]={8,7.5,8.5,{3,5,10,11,12,13,15,20,21,22}},
[380]={8,8,8,{3,12,13,22}},
[381]={8,8,8,{9,19}},
[383]={8,7.5,8.5,{8,11,18,21}},
[385]={8,7.5,8.5,{3,5,8,11,12,13,15,18,21,22}},
[386]={8,7.5,8.5,{3,5,11,13,15,21}},
[387]={7.5,8,8.5,{3,5,13,15}},
[388]={8.5,8,7.5,{3,6,7,13,16,17}},
[389]={8.5,7.5,8,{3,4,5,6,7,8,9,10,11,12}},
[391]={8,7,9,{3,5,9,13,15,19}},
[392]={8,7.5,8.5,{3,5,9,11,13,15,19,21}},
[393]={8.5,7,8.5,{5,6,7,9,11,12,15,16,17,19,21,22}},
[395]={8.5,8,7.5,{3,6,7,13,16,17}},
[396]={7,8.5,8.5,{11,18,21}},
[397]={8,8,8,{3,9,11,12,13,19,21,22}},
[398]={8,7.5,8.5,{3,5,9,11,13,15,19,21}},
[399]={7.5,8,8.5,{3,5,8,13,15,18}},
[400]={7,8.5,8.5,{11,13,14,19,21}},
[401]={8.5,8,7.5,{3,6,7,13,16,17}},
[402]={8.5,8,7.5,{3,9,12,13,19,22}},
[403]={7.5,8,8.5,{3,5,8,10,13,15,18,20}},
[404]={8,7.5,8.5,{3,12,13,22}},
[405]={7.5,8,8.5,{3,4,7,13,14,17}},
[406]={8.5,7.5,8,{3,6,7,9,13,16,17,19}},
[407]={7,8.5,8.5,{11,13,15,18,21}},
[408]={7.5,8,8.5,{3,5,11,13,15,21}},
[409]={7,8,9,{5,8,10,15,18,20}},
[410]={8,7.5,8.5,{3,5,9,11,13,15,19,21}},
[411]={8,8,8,{3,4,13,14}},
[412]={7,8.5,8.5,{11,13,15}},
[414]={8,8,8,{3,8,13,18}},
[415]={7.5,8.5,8,{6,7,9,16,17,19}},
[416]={8,8,8,{3,5,8,13,15,18}},
[417]={8,7.5,8.5,{3,5,9,11,13,15,19,21}},
[418]={7.5,8,8.5,{3,11,13,21}},
[419]={8.5,7.5,8,{3,11,13,21}},
[420]={8.5,7.5,8,{3,7,12,13,17,22}},
[421]={8,8.5,7.5,{3,9,12,13,19,22}},
[422]={7.5,8.5,8,{3,5,8,13,15,18}},
[423]={8.5,8.5,7,{3,6,9}},
[424]={8.5,7,8.5,{5,6,7,9,11,12,15,16,17,19,21,22}},
[425]={7.5,8,8.5,{3,8,10,13,18,20}},
[427]={7,8.5,8.5,{9,13,19}},
[428]={7,8.5,8.5,{11,13,15,18,21}},
[429]={7.5,8.5,8,{4,6,7,9,14,16,17,19}},
[430]={8,8.5,7.5,{5,15}},
[431]={7.5,8,8.5,{8,9,18,19}},
[432]={8,8,8,{3,8,13,18}},
[433]={7.5,8,8.5,{3,5,7,13,15,17}},
[437]={8,8,8,{3,10}},
[438]={7.5,8,8.5,{6,9,16,19}},
[439]={8.5,8,7.5,{6,9,16,19}},
[440]={8,8,8,{3,4,8,13,14,18}},
[441]={8,7,9,{5,7,9,15,17,19}},
[442]={9,6.5,8.5,{6,7,9,12,16,17,19,22}},
[443]={8,8,8,{3,5,7,9,11,12,13,17,19,21,22}},
[445]={8,8,8,{6,7,9,10}},
[446]={8.5,8,7.5,{3,4,6,9}},
[447]={8,7.5,8.5,{3,5,9,11,12,13,15,19,21,22}},
[448]={8,7,9,{3,5,7,9,11,12,13,17,19,21,22}},
[449]={8,8,8,{3,5,11,13,15,21}},
[450]={9,8,7,{3,6,13,16}},
[452]={8,8,8,{3,5,10,11,12,13,15,20,21,22}},
[453]={9,8,7,{6,7,16,17}},
[454]={8,7.5,8.5,{3,5,9,11,13,15,19,21}},
[455]={8,8,8,{7,8,10,17,18,20}},
[456]={8,8.5,7.5,{3,6,7,8,13,16,17,18}},
[457]={9,8,7,{6,9,16,19}},
[458]={8.5,8.5,7,{3,6,13,16}},
[459]={7,8.5,8.5,{3,5,8,11,13,15,18,21}},
[460]={7.5,8.5,8,{3,6,9}},
[461]={9,8,7,{3,13}},
[463]={9,9,6,{6,9,16,19}},
[464]={8,8,8,{3,5,9,13,15,19}},
[465]={7,8.5,8.5,{3,4,8,13,14,18}},
[466]={7.5,8,8.5,{3,5,7,13,15,17}},
[467]={7.5,8.5,8,{3,6,7,9,13,16,17,19}},
[468]={7.5,8.5,8,{3,6,7,9,13,16,17,19}},
[469]={7,8.5,8.5,{3,4,6,7,9,13,14,16,17,19}},
[470]={7,8.5,8.5,{11,13,14,17}},
[471]={8.5,7.5,8,{13,15,16,18,19,20}},
[472]={8.5,7.5,8,{3,4,5,6,7,8,10,11}},
[473]={9,7.5,7.5,{3,9,13,19}},
[474]={6,8,10,{5,15}},
[475]={8.5,7,8.5,{3,12,13,22}},
[477]={7.5,7.5,9,{3,11,13,21}},
[478]={8.5,8,7.5,{3,9,11,12,13,19,21,22}},
[479]={8,6.5,9.5,{3,11,13,21}},
[480]={8,8.5,7.5,{3,6,9}},
[482]={7.5,8,8.5,{3,5,13,15}},
[483]={8.5,7.5,8,{3,12,13,22}},
[484]={7,8.5,8.5,{11,13,15,18}},
[485]={9,7.5,7.5,{6,7,9,16,17,19}},
[487]={8,8,8,{3,5,7,10,11,12,13,15,17,20,21,22}},
[488]={7.5,8,8.5,{12,22}},
[489]={8,8.5,7.5,{4,8,10,14,18,20}},
[491]={7,9,8,{5,8,15,18}},
[492]={8,8.5,7.5,{3,6,9,13,16,19}},
[493]={9.5,8.5,6,{3,6,7,13,16,17}},
[494]={8,8,8,{3,6,7,13,16,17}},
[495]={8.5,7.5,8,{3,12,13,22}},
[496]={9.5,8.5,6,{3,9,12,13,19,22}},
[497]={8.5,7,8.5,{6,7,9,12,16,17,19,22}},
[498]={8.5,8,7.5,{3,8,9,13,18,19}},
[499]={8,7.5,8.5,{7,17}},
[500]={8,8,8,{3,4,6,7,8,10}},
[502]={8.5,7.5,8,{3,12,13,22}},
[503]={7.5,7.5,9,{3,5,11,13,15,21}},
[504]={8,8.5,7.5,{3,4,10,13,14,20}},
[505]={7.5,8,8.5,{3,5,7,11,13,15,17,21}},
[506]={7,8.5,8.5,{11,13,16,19}},
[507]={7.5,8.5,8,{3,9,12,13,19,22}},
[508]={8,8,8,{3,4,7,13,14,17}},
[509]={8,8,8,{6,7,9}},
[511]={7.5,8,8.5,{3,5,11,13,15,21}},
[512]={7.5,8.5,8,{4,6,9,12,14,16,19,22}},
[514]={8,8,8,{3,4,5,6,7,8,9,10,11,12}},
[515]={8,8,8,{3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22}},
[517]={8,8,8,{3,8,13,18}},
[518]={9,8.5,6.5,{3,6,13,16}},
[519]={8.5,8,7.5,{6,7,9}},
[521]={7,9,8,{10,20}},
[523]={9,8,7,{6,9,16,19}},
[525]={8,8,8,{3,5,12,13,15,22}},
[528]={7.5,8,8.5,{9,12,19,22}},
[529]={8,8,8,{4,7,14,17}},
[530]={8,8,8,{3,6,7,9}},
[532]={8.5,9,6.5,{4,6,14,16}},
[534]={7.5,8.5,8,{3,4,5,8,10,13,14,15,18,20}},
[535]={8,8,8,{3,9}},
[536]={8.5,8,7.5,{7,9,17,19}},
[537]={8.5,8,7.5,{3,4,6,7,13,14,16,17}},
[538]={8.5,8.5,7,{6,8,16,18}},
[539]={8,7.5,8.5,{3,5,10,11,12,13,15,20,21,22}},
[540]={8,7.5,8.5,{3,5,10,11,12,13,15,20,21,22}},
[541]={8.5,7,8.5,{5,6,7,9,15,16,17,19}},
[542]={8.5,7.5,8,{3,12,13,22}},
[543]={7.5,8.5,8,{3,5,9,13,15,19}},
[544]={8.5,8.5,7,{5,11,12,15,21,22}},
[545]={8,8,8,{3,5,8,13,15,18}},
[546]={7.5,8.5,8,{6,9,12,16,19,22}},
[547]={8,7,9,{3,5,7,9,10,11,13,15,17,19,20,21}},
[548]={7.5,8.5,8,{3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22}},
[549]={8,8,8,{3,5,10,11,12,13,15,20,21,22}},
[550]={8,7.5,8.5,{3,5,10,11,12,13,15,20,21,22}},
[552]={7.5,8.5,8,{3,4,6,7,11,13,14,16,17,21}},
[553]={8,7.5,8.5,{3,5,10,11,12,13,15,20,21,22}},
[554]={7.5,8.5,8,{3,7,9}},
[555]={8.5,7,8.5,{5,6,7,9,15,16,17,19}},
[556]={7.5,8.5,8,{6,9,12,16,19,22}},
[557]={7.5,8.5,8,{4,5,7,10,11,14,15,17,20,21}},
[558]={8,8,8,{8,18}},
[559]={7.5,9,7.5,{4,6,7,9}},
[560]={8.5,7.5,8,{3,5,10,13,15,20}},
[562]={7.5,8,8.5,{3,5,8,13,15,18}},
[564]={9.5,7.5,7,{3,6,12,13,16,22}},
[565]={8.5,7.5,8,{3,12,13,22}},
[566]={7.5,7.5,9,{3,9,12,13,19,22}},
[567]={7.5,8,8.5,{5,10,15,20}},
[568]={9.5,8.5,6,{3,9,13,19}},
[569]={8.5,7.5,8,{3,12,13,22}},
[570]={8,8,8,{3,10,13,20}},
[571]={7.5,8,8.5,{3,5,13,15}},
[572]={8.5,8,7.5,{4,6,14,16}},
[573]={9,7,8,{3,5,10,11,13,15,20,21}},
[626]={7.5,8,8.5,{4,5,7,8,10,11,14,15,17,18,20,21}},
[627]={8.5,8.5,7,{7,10,17,20}},
[628]={8.5,8,7.5,{3,10,13,20}},
[629]={8.5,8,7.5,{3,4,7,13,14,17}},
[630]={8,8,8,{3,5,8,10,13,15,18,20}},
[631]={7.5,8,8.5,{7,9,17,19}},
[632]={7.5,8,8.5,{3,10,13,20}},
[633]={8,8,8,{3,7,9,12,13,17,19,22}},
[634]={7,8.5,8.5,{9,13,19}},
[635]={7.5,8,8.5,{3,8,10,13,18,20}},
[637]={8,8,8,{11,13,15}},
[638]={8.5,7,8.5,{5,6,7,9,15,16,17,19}},
[639]={8,7.5,8.5,{3,5,10,11,12,13,15,20,21,22}},
[640]={8,7,9,{3,5,7,9,11,12,13,17,19,21,22}},
[641]={8,7,9,{3,5,7,9,11,12,13,17,19,21,22}},
[644]={8,7.5,8.5,{3,5,10,11,12,13,15,20,21,22}},
[645]={8,8,8,{3,8,9,13,18,19}},
[646]={8,8,8,{13,15,21,22}},
[647]={8,8,8,{3,5,8,10,11,13,15,18,20,21}},
[648]={9,7.5,7.5,{3,6,7,12,13,16,17,22}},
[649]={9,7.5,7.5,{3,7,8,13,17,18}},
[650]={8.5,8,7.5,{8}},
[652]={8,8,8,{21}},
[665]={7.5,8.5,8,{11}},
[671]={8,8,8,{8,18}},
[675]={8,7.5,8.5,{3,5,10,11,12,13,15,20,21,22}},
[677]={8,8,8,{3,5,8,13,15,18}},
[678]={8,8,8,{6,9,16,19}},
[679]={8,8,8,{5,11,15,21}},
[680]={8,8,8,{5,11,15,21}},
[699]={7,8.5,8.5,{11,13,19,22}},
[702]={8.5,7.5,8,{3,5,12,13,15,22}},
[703]={8,8,8,{3,11,13,21}},
[706]={8,8,8,{3,5,8,13,15,18}},
[707]={8,8,8,{3,5,13,15}},
[708]={8,7.5,8.5,{3,5,10,11,12,13,15,20,21,22}},
[709]={8,7.5,8.5,{3,5,11,12,13,15,21,22}},
[710]={8,8,8,{3,9,11,13,19,21}},
[711]={8,8,8,{3,5,11,13,15,21}},
[712]={8,8,8,{3,5,11,13,15,21}},
[713]={9,7.5,7.5,{3,9,13,19}},
[714]={7,8.5,8.5,{11,13,14,20}},
[716]={7,8.5,8.5,{9,17,19}},
[717]={7.5,8.5,8,{5,6,9,12,15,16,19,22}},
[718]={8,8,8,{3,8,9,13,18,19}},
[722]={7.5,8.5,8,{3,9,10,12}},
[723]={9,7.5,7.5,{3,6,9,13,16,19}},
[724]={8,8,8,{5,10,15,20}},
[725]={8,8,8,{3,11,13,21}},
[726]={7,8.5,8.5,{3,5,7,13,15,17}},
[727]={8,8,8,{3,5,8,11,12,13,15,18,21,22}},
[728]={8,8,8,{13,15,21,22}},
[729]={8,7,9,{3,5,7,9,11,12,13,17,19,21,22}},
[730]={8,7,9,{3,5,9,11,12,13,19,21,22}},
[731]={7,8.5,8.5,{7,9,17,19}},
[732]={8,8.5,7.5,{8,9,18,19}},
[733]={8,8,8,{3,5,11,13,15,21}},
[737]={6.5,8,9.5,{5,8,15,18}},
[739]={7,8,9,{5,8,15,18}},
[740]={8,7.5,8.5,{3,9,10,11,12,13,19,20,21,22}},
[741]={8,8,8,{3,12,13,22}},
[742]={8,8,8,{3,5,13,15}},
[743]={9.5,8.5,6,{3,5,12,13,15,22}},
[744]={8.5,7,8.5,{5,6,7,9,11,12,15,16,17,19,21,22}},
[745]={8,8,8,{3,9,13,19}},
[746]={8.5,9,6.5,{4,6,14,16}},
[747]={7.5,8.5,8,{3,9,10,12}},
[748]={8,8.5,7.5,{3,5,7,8,9,10,11,12,13,15,17,18,19,20,21,22}},
[749]={8,8,8,{5,11,15,21}},
[750]={8,8,8,{3,5,11,13,15,21}},
[751]={8,7.5,8.5,{3,9,11,12,13,19,21,22}},
[752]={9,7.5,7.5,{3,4,12,13,14,22}},
[753]={7.5,8.5,8,{3,9,13,19}},
[754]={8,8,8,{3,5,7,8,9,11,12,13,15,17,18,19,21,22}},
[755]={9,6.5,8.5,{8,10,18,20}},
[756]={8.5,7,8.5,{3,5,9,13,15,19}},
[757]={8.5,8,7.5,{15}},
[758]={7.5,8.5,8,{18}},
[792]={8,8.5,7.5,{3,12,13,22}},
[802]={8.5,8.5,7,{4}},
[817]={8.5,8,7.5,{7}},
[818]={8,8.5,7.5,{8}},
[819]={7.5,8.5,8,{15}},
[820]={8,8,8,{22}},
[821]={8,8,8,{11,21}},
[823]={8,8,8,{3,5,9,12,13,15,19,22}},
[834]={8.5,8,7.5,{7}},
[835]={8,8,8,{5,15}},
[836]={7.5,7,9.5,{5}},
[837]={8.5,8,7.5,{3,4,5,6,7,8,9,10,11,12}},
[838]={8,8,8,{3,4,5,6,7,8,9,10,11,12}},
[844]={8,8.5,7.5,{5}},
[845]={8,8,8,{3,8,10,13,18,20}},
[846]={6,8,10,{5,15}},
[847]={8,8,8,{22}},
[848]={8,7,9,{3,5,9,13,15,19}},
[851]={7.5,8,8.5,{3,5,7,13,15,17}},
[855]={7.5,8.5,8,{3}},
[856]={8,8,8,{9,12}},
[868]={8,8,8,{9}},
[872]={8,8,8,{}},
[873]={8,8,8,{}},
[874]={8,8,8,{}},
[875]={8,8,8,{}},
[876]={8,8,8,{}},
[877]={8,8,8,{}},
[878]={8,8,8,{}},
[879]={8,8,8,{}},
[880]={8,8,8,{}},
[881]={8,8,8,{}},
[882]={8,8,8,{}},
[883]={8,8,8,{}},
[884]={8,8,8,{}},
[885]={8,8,8,{}},
[886]={8,8,8,{}},
[887]={8,8,8,{}},
[888]={8,8,8,{}},
[889]={8,8,8,{}},
[890]={8,8,8,{}},
[891]={8,8,8,{}},
[892]={8,8,8,{}},
[893]={8,8,8,{}},
[894]={8,8,8,{}},
[895]={8,8,8,{}},
[896]={8,8,8,{}},
[897]={8,8,8,{}},
[898]={8,8,8,{}},
[899]={8,8,8,{}},
[900]={8,8,8,{}},
[901]={8,8,8,{}},
[902]={8,8,8,{}},
[903]={7.5,9,7.5,{10}},
[904]={8,8,8,{}},
[905]={8,8,8,{}},
[906]={8,8,8,{}},
[907]={8,8,8,{}},
[908]={8,8,8,{}},
[909]={8,8,8,{}},
[911]={8,8.5,7.5,{}},
[912]={8,8.5,7.5,{}},
[913]={8,8.5,7.5,{}},
[915]={8,8,8,{}},
[916]={8,8,8,{}},
[917]={8,8,8,{}},
[921]={8,8,8,{}},
[922]={8,8,8,{}},
[923]={8.5,7.5,8,{}},
[924]={8,8,8,{}},
[925]={8,8,8,{}},
[926]={8,8,8,{}},
[927]={8,8,8,{}},
[928]={8,8,8,{}},
[929]={8,8,8,{}},
[931]={8,8,8,{}},
[932]={8,8,8,{}},
[933]={8,8,8,{}},
[934]={8,8,8,{}},
[935]={8,8,8,{}},
[936]={8,8,8,{}},
[937]={8,8,8,{}},
[938]={8,8,8,{}},
[939]={8,8,8,{}},
[941]={8,8,8,{}},
[942]={8,8,8,{}},
[943]={8,8,8,{}},
[944]={8,8,8,{}},
[945]={8,8,8,{}},
[946]={8,8,8,{}},
[947]={8,8,8,{}},
[948]={8,8,8,{}},
[949]={8,8,8,{}},
[950]={8,8,8,{}},
[951]={8,8,8,{}},
[952]={8,8,8,{}},
[953]={8,8,8,{}},
[954]={8,8,8,{}},
[955]={8,8,8,{}},
[956]={8,8,8,{}},
[957]={8,8,8,{}},
[958]={8,8,8,{}},
[959]={8,8,8,{}},
[960]={8,8,8,{}},
[961]={8,8,8,{}},
[962]={8,8,8,{}},
[963]={8,8,8,{}},
[964]={8,8,8,{}},
[965]={8,8,8,{}},
[966]={8,8,8,{}},
[967]={8,8,8,{}},
[968]={8,8,8,{}},
[969]={8,8,8,{}},
[970]={8,8,8,{}},
[971]={8,8,8,{}},
[972]={8,8,8,{}},
[973]={8,8,8,{}},
[974]={8,8,8,{}},
[975]={8,8,8,{}},
[976]={8,8,8,{}},
[977]={8.5,8.5,8.5,{9}},
[978]={8.5,8.5,8.5,{8}},
[979]={8.5,8.5,8.5,{6}},
[980]={8.5,8.5,8.5,{}},
[981]={8.5,8.5,8.5,{}},
[982]={8.5,8.5,8.5,{}},
[983]={8.5,8.5,8.5,{}},
[984]={8.5,8.5,8.5,{}},
[985]={8.5,8.5,8.5,{}},
[986]={8.5,8.5,8.5,{}},
[987]={8.5,8.5,8.5,{}},
[988]={8.5,8.5,8.5,{}},
[989]={8,8,8,{9}},
[990]={8,8,8,{5}},
[991]={8,8,8,{8}},
[992]={8,8,8,{6}},
[993]={8,8,8,{5}},
[994]={8,8,8,{8}},
[995]={8,8,8,{9}},
[996]={8,8,8,{6}},
[997]={8,8,8,{7}},
[998]={8,8,8,{9}},
[999]={8,8,8,{6}},
[1000]={8,8,8,{8}},
[1001]={8,8,8,{8}},
[1002]={9,9,9,{9}},
[1003]={9,9,9,{9}},
[1004]={8,8,8,{9}},
[1005]={8,8,8,{9}},
[1006]={8,8,8,{6}},
[1007]={8,8,8,{4}},
[1008]={8,8,8,{6}},
[1009]={8,8,8,{7}},
[1010]={8,8,8,{8}},
[1011]={8,8,8,{7}},
[1012]={8,8,8,{5}},
[1013]={9,7.5,7.5,{3,6,9,13,16,19}},
[1039]={7.5,7.5,9,{6,16}},
[1040]={8,8,8,{6,16}},
[1042]={6.75,10.5,6.75,{8}},
[1061]={8,8,8,{5}},
[1062]={8,7.5,8.5,{3,9,10,12}},
[1065]={8,8.5,7.5,{8}},
[1066]={8,8,8,{10}},
[1067]={8.5,7.5,8,{7}},
[1073]={8,8,8,{22}},
[1124]={8,8,8,{8}},
[1125]={8,8,8,{3}},
[1126]={8,8,8,{7}},
[1128]={8,8,8,{3,12,13}},
[1142]={8.5,7.5,8,{11}},
[1143]={8,8,8,{18}},
[1144]={8,8,8,{9}},
[1145]={8,8,8,{5}},
[1146]={8,8,8,{7}},
[1147]={8,8,8,{4}},
[1149]={8,8,8,{8}},
[1150]={8,8,8,{9}},
[1151]={8,8,8,{7}},
[1152]={7.5,8.5,8,{6}},
[1153]={8,8,8,{4}},
[1154]={8,8,8,{9}},
[1155]={8,8.5,7.5,{6}},
[1156]={8,8,8,{18}},
[1157]={8,8,8,{3,12,13,22}},
[1158]={8,8,8,{12}},
[1159]={7.5,8.5,8,{12}},
[1160]={8.5,8,7.5,{8}},
[1161]={8,8.5,7.5,{4,8,10,14,20}},
[1162]={7,9,8,{5,8,15,18}},
[1163]={9,8,7,{6,7,16,17}},
[1164]={7.5,8,8.5,{3,5,11,13,15,21}},
[1165]={8,8.5,7.5,{4,8,10,14,18,20}},
[1166]={8,8.5,7.5,{4,8,10,14,18,20}},
[1167]={8,8.5,7.5,{4,8,10,14,18,20}},

[1127]={7.5,8.5,8,{8}},

[1134]={8,8,8,{9}},---土灵组
[1137]={8,8,8,{6}},
[1141]={8,8,8,{7}},
[1135]={8,8,8,{12}},---风灵组
[1136]={8,8,8,{3}},
[1140]={8,8,8,{3}},
[1132]={8,8,8,{5}},---水灵组
[1133]={8,8,8,{10}},
[1138]={8,8,8,{9}},
[1130]={8,8,8,{8}},---水灵组
[1131]={8,8,8,{11}},
[1139]={8,8,8,{8}},


[1068]={8,8,8,{3,5,8,10,13,15,18,20}},
[1063]={8.5,8.5,7,{8}},
[1117]={7,8.5,8.5,{3}},
[513]={8,8,8},-------等待夏天
}
--http://schaffhauser.me/api/wow/data/pet/stats/id
HPetDate.GetBreedByID=function(breedID)
	if breedID==3 or breedID==13 then
		return 0.5,0.5,0.5
	elseif breedID==4 or breedID==14 then
		return 0,2,0
	elseif breedID==5 or breedID==15 then
		return 0,0,2
	elseif breedID==6 or breedID==16 then
		return 2,0,0
	elseif breedID==7 or breedID==17 then
		return 0.9,0.9,0
	elseif breedID==8 or breedID==18 then
		return 0,0.9,0.9
	elseif breedID==9 or breedID==19 then
		return 0.9,0,0.9
	elseif breedID==10 or breedID==20 then
		return 0.4,0.9,0.4
	elseif breedID==11 or breedID==21 then
		return 0.4,0.4,0.9
	elseif breedID==12 or breedID==22 then
		return 0.9,0.4,0.4
	end
	return
end

HPetDate.SearchNoPet=function()
	for i = 1 , 600 do
		if select(15,C_PetJournal.GetPetInfoByIndex(i)) then
			local _,id=C_PetJournal.GetPetInfoByIndex(i)
			if not HPetDate[id] then
				local str=select(8,C_PetJournal.GetPetInfoByIndex(i))
				print(str,id)
			end
		end
	end
end

HPetDate.GetBreedValue=function(petstate,speciesID,ifprint)
	local level,health,power,speed,rarity,isflying = petstate.level, petstate.health, petstate.power, petstate.speed, petstate.rarity, petstate.isflying
	local breed=tonumber("1."..(rarity-1 or 0))
	if petstate and  speciesID and HPetDate[speciesID] then
		local thealth,tpower,tspeed = HPetDate[speciesID][1],HPetDate[speciesID][2],HPetDate[speciesID][3]
		local bhealth,bpower,bspeed
		local breedID

		local GetBreedIDbySystem = function()
			for i = 3 , 12 do
				bhealth,bpower,bspeed=HPetDate.GetBreedByID(i)
				if math.abs(format("%.1f",(bhealth+thealth)*5*level*breed+100) - format("%.0f",health)) <= 0.5*5 then
					if math.abs(format("%.1f",(bpower+tpower)*level*breed) - format("%.0f",power)) <= 0.5 then
						if math.abs(format("%.1f",(bspeed+tspeed)*level*breed) - format("%.0f",speed)) <= 0.5*(isflying and 1.5 or 1) then
							breedID=i
							return true
						end
					end
				end
			end
			return false
		end
		local GetBreedIDbyPetDate = function()
			if not HPetDate[speciesID][4] then return false end
			for _,i in pairs(HPetDate[speciesID][4]) do
				bhealth,bpower,bspeed=HPetDate.GetBreedByID(i)
				if math.abs(format("%.1f",(bhealth+thealth)*5*level*breed+100) - format("%.0f",health)) <= 0.5*5 then
					if math.abs(format("%.1f",(bpower+tpower)*level*breed) - format("%.0f",power)) <= 0.5 then
						if math.abs(format("%.1f",(bspeed+tspeed)*level*breed) - format("%.0f",speed)) <= 0.5*(isflying and 1.5 or 1)  then
							breedID=i
							return true
						end
					end
				end
			end
			return false
		end
		local SaveNewpetstate = function()
			if HPetSaves.god then
				if not HPetDate[speciesID][4] then HPetDate[speciesID][4]={} end
				local HasID=function()
					for k,v in pairs(HPetDate[speciesID][4]) do
						if breedID == tonumber(v) or breedID+10 == tonumber(v) then return true end
					end
					return false
				end
				if not HasID() then
					if not HPetSaves.HPetOtherDate then HPetSaves.HPetOtherDate={} end
					if not HPetSaves.HPetOtherDate[speciesID] then HPetSaves.HPetOtherDate[speciesID]={} end
					table.insert(HPetDate[speciesID][4],breedID)
				end
			end
		end

		if GetBreedIDbyPetDate() then
			if ifprint then
				return bhealth+thealth,bpower+tpower,bspeed+tspeed,breedID
			else
				return bhealth,bpower,bspeed,breedID,thealth,tpower,tspeed
			end
		elseif GetBreedIDbySystem() then
			printt("宠物数据未收集")
			if ifprint then
				return bhealth+thealth,bpower+tpower,bspeed+tspeed,breedID
			else
				return bhealth,bpower,bspeed,breedID,thealth,tpower,tspeed
			end
		end
		printt("宠物数据异常")
	else
		if select(8,C_PetJournal.GetPetInfoBySpeciesID(speciesID)) then
			printt("没有"..speciesID.."的基础数据")
		end
	end

	---------------没有基础数据，计算
	local bhealth=format("%.1f",(health-100)/5/level/breed)
	local bpower=format("%.1f",power/level/breed)
	local bspeed=format("%.1f",speed/level/breed)

	return	bhealth,bpower,bspeed,nil,0,0,0
end

HPetDate.GetIDByBreed=function(h,p,s)
	for i = 3 , 12 do
		local gh,gp,gs = HPetDate.GetBreedByID(i)
		if math.abs(format("%f",gh - h)) <= 0.25 then
			if math.abs(format("%f",gp - p)) <= 0.25 then
				if math.abs(format("%f",gs - s)) <= 0.25 then
					return i
				end
			end
		end
	end
end



---------------------------------------PetAllInfo.lua
local HPetAllInfoFrame=CreateFrame("Frame","HPetAllInfoFrame",UIParent)
local backdrop={
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	edgeSize = 16,
}
local TABLE1={"BreedID","Health","Power","Speed"}
local TABLE2={"Health","Power","Speed"}
local LINECOLOR={0.5, 0.5, 0.5, 1}
local SELFHEIGHT = 0
function HPetAllInfoFrame:Update(speciesID,breedID,rarityvalue)
	local selfheight = SELFHEIGHT
	local speciesID = speciesID or PetJournalPetCard.speciesID
	local breedID = breedID or PetJournalPetCard.breedID;PetJournalPetCard.breedID=breedID
	local rarityvalue = rarityvalue or HPetAllInfoFrame.rarityvalue or 4
	if not HPetAllInfoFrame:IsShown() or not speciesID then return end

	if self ~= HPetAllInfoFrame and not HPetAllInfoFrame.lockrarity then
		if PetJournalPetCard.petID then
			rarityvalue = select(5,C_PetJournal.GetPetStats(PetJournalPetCard.petID))
		end
	end

	local name, icon, petType, creatureID, sourceText, description, isWild, canBattle, tradable, unique = C_PetJournal.GetPetInfoBySpeciesID(speciesID);

	HPetAllInfoFrame.petName.text:SetText(name)
	HPetAllInfoFrame.petName.icon:SetTexture("Interface\\Icons\\Pet_TYPE_"..PET_TYPE_SUFFIX[petType])


	----------------------------------------------------------------
	local pet=HPetDate[speciesID]
	height=SELFHEIGHT + HPetAllInfoFrame.baseTable.UpdateInfo(pet,breedID)


	----------------------------------------------------------------
	if HPetAllInfoFramerarityButton then
		HPetAllInfoFramerarityButton:SetText(format(ITEM_QUALITY_COLORS[rarityvalue-1].hex.."%s|r",(_G["BATTLE_PET_BREED_QUALITY"..rarityvalue])))
	end

	HPetAllInfoFrame.levelTable.UpdateInfo(pet,breedID,25,rarityvalue)

	HPetAllInfoFrame:UpdateSize(height);
	updateElapsed = 0
end

function HPetAllInfoFrame:Init()

	-- init frame
	self:SetParent(PetJournal)
	self:SetWidth(350)
	self:SetPoint("TOPLEFT",PetJournal,"TOPRIGHT")
	self:SetFrameStrata("HIGH")
	self:SetToplevel(true)
	self:SetMovable(true)
	self:SetClampedToScreen(true)

	-- background
	self.rightbg	=self:CreateVLine(0, 0, 0, 1,LINECOLOR)
	self.leftbg		=self:CreateVLine(0, 0, 0, 1,LINECOLOR)
	self.midbg		=self:CreateVLine(0, 0, 0, 1,{1,1,0,1})
	self.topbg		=self:CreateHLine(0, 0, 0, 1,LINECOLOR)
	self.bottombg	=self:CreateHLine(0, 0, 0, 1,LINECOLOR)
	self.UpdateSize=function(self,height)
		self.rightbg:SetPos	(self:GetWidth(), 	0, -height, 1)
		self.leftbg:SetPos	(0, 				0, -height, 1)
		self.midbg:SetPos	(self:GetWidth()/2+25,	-27, -height, 1)
		self.topbg:SetPos	(self:GetWidth(), 	0, 0, 		1)
		self.bottombg:SetPos(self:GetWidth(), 	0, -height, 1)
		self:SetHeight(height)
	end
	self:SetBackdrop( {
	  bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
	  edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	  tile = true, tileSize = 16, edgeSize = 16,
	});
	self:SetBackdropColor(0,0,0)
	self:SetAlpha(1)
	-- drag
	self:EnableMouse(true)
	self:RegisterForDrag("LeftButton")
	self:SetScript("OnDragStart",function(self) self:StartMoving() end)
	self:SetScript("OnDragStop",function(self) self:StopMovingOrSizing() end)
	frames={
		-- name
		{name="petName",width="350",height="30",
		point="TOPLEFT",
		font={text=NAME},
		texture={point="RIGHT",repoint="LEFT",size=26},
		},

		--------------左

		-- breed
		{name="breed",width="50",height="60",
		point="TOPLEFT",relative="petName",repoint="BOTTOMLEFT",
		font={text=L["Breed"]},
		},

		-- base point
		{name="base",width="150",height="30",
		point="TOPLEFT",relative="breed",repoint="TOPRIGHT",
		font={text=L["Base Points"]},
		},

		-- icon1
		{name="icon11",width="50",height="30",
		point="TOPLEFT",relative="base",repoint="BOTTOMLEFT",
		texture={icon="Interface\\PetBattles\\PetBattle-StatIcons",coords={0.5,1.0,0.5,1.0},}
		},
		{name="icon12",width="50",height="30",
		point="TOPLEFT",relative="icon11",repoint="TOPRIGHT",
		texture={icon="Interface\\PetBattles\\PetBattle-StatIcons",coords={0.0,0.5,0.0,0.5},}
		},
		{name="icon13",width="50",height="30",
		point="TOPLEFT",relative="icon12",repoint="TOPRIGHT",
		texture={icon="Interface\\PetBattles\\PetBattle-StatIcons",coords={0.0,0.5,0.5,1},}
		},

		--------------右

		-- level
		{name="level",width="150",height="30",
		point="TOPLEFT",relative="base",repoint="TOPRIGHT",
		font={text=LEVEL..":25"},
		},

		-- rarity
		{name="rarity",width="150",height="30",
		point="TOPLEFT",relative="level",repoint="BOTTOMLEFT",
		font={text=PET_BATTLE_STAT_QUALITY..":",point="LEFT"},
		},

		-- icon2
		{name="icon21",width="50",height="30",
		point="TOPLEFT",relative="rarity",repoint="BOTTOMLEFT",
		texture={icon="Interface\\PetBattles\\PetBattle-StatIcons",coords={0.5,1.0,0.5,1.0},}
		},
		{name="icon22",width="50",height="30",
		point="TOPLEFT",relative="icon21",repoint="TOPRIGHT",
		texture={icon="Interface\\PetBattles\\PetBattle-StatIcons",coords={0.0,0.5,0.0,0.5},}
		},
		{name="icon23",width="50",height="30",
		point="TOPLEFT",relative="icon22",repoint="TOPRIGHT",
		texture={icon="Interface\\PetBattles\\PetBattle-StatIcons",coords={0.0,0.5,0.5,1},}
		},
	}
	SELFHEIGHT = 90
	self:initframe(frames)
	self:CreateDropDown("rarity")
	self.lockrarity = true
	--------------------------------------CheckButton1
	local lock=CreateFrame("CheckButton",self:GetName().."lockrarity",_G[self:GetName().."rarity"],"OptionsCheckButtonTemplate")
	lock:SetChecked(1)
	lock:SetPoint("RIGHT")
	lock:SetScript("OnClick",function(self)
		isChecked = self:GetChecked()
		if isChecked then
			PlaySound("igMainMenuOptionCheckBoxOn")
		else
			PlaySound("igMainMenuOptionCheckBoxOff")
		end
		HPetAllInfoFrame.lockrarity = isChecked or false
	end)
	lock:SetScript("OnEnter",function(s)
		GameTooltip:SetOwner(button,"ANCHOR_NONE");
		GameTooltip:SetPoint("BOTTOMLEFT",lock,"TOPRIGHT")
		GameTooltip:AddLine(L["lock rarity"], 1, 1, 1, true);
		GameTooltip:Show()
	end)
	--------------------------------------button1
	local button=CreateFrame("Button",self:GetName().."Switch",self,"UIMenuButtonStretchTemplate")
	button.value=true
	button:SetText("|cff69ccf0"..L["Switch"].."|r")
	button:SetSize(50,30)
	_G[button:GetName().."Left"]:SetAlpha(0.5)
	_G[button:GetName().."Right"]:SetAlpha(0.5)
	_G[button:GetName().."Middle"]:SetAlpha(0.5)
	button:SetPoint("TOPLEFT",_G[self:GetName().."breed"],"BOTTOMLEFT")
	button:SetScript("OnClick",function(self)
		self.value=not self.value
		if self.value then
			self:SetText("|cff69ccf0"..L["Switch"].."|r")
		else
			self:SetText("|cff00ff96"..L["Switch"].."|r")
		end
		self:GetParent():Update()
	end)
	--------------------------------------

	self.baseTable = self:CreateTable(self:GetName().."base",TABLE1,self["breed"]:GetWidth()*4,30,"TOPLEFT",self:GetName().."breed","BOTTOMLEFT",true,0,-30)

	self.levelTable = self:CreateTable(self:GetName().."level",TABLE2,self["breed"]:GetWidth()*3,30,"TOPLEFT",self:GetName().."icon21","BOTTOMLEFT")

	self:UpdateSize(SELFHEIGHT);
	self.ready=true
	self:Hide()

	hooksecurefunc("PetJournal_UpdatePetCard",self.Update)
	PetJournal:SetScript("OnHide",function() self:Hide() end)
end

function HPetAllInfoFrame:CreateDropDown(name,dtype)
	local tempDropDown=CreateFrame("Frame",self:GetName()..name.."DropDown",HPetAllInfoFrame[name] or nil,"UIDropDownMenuTemplate")
	local function tempDropDownInit(self,level)
		local info = UIDropDownMenu_CreateInfo();
		info.keepShownOnClick  = false;
		info.isNotRadio = true;
		info.notCheckable = true;
		if dtype == "level" then
			for i = 1, 25 do
				info.value = i;
				info.text = format(i)
				info.func = function()
								if _G["HPetAllInfoFramelevelButton"] then
									HPetAllInfoFramelevelButton:SetText(i)
								end
								HPetAllInfoFrame[name.."value"] = i
								HPetAllInfoFrame:Update()
							end
				UIDropDownMenu_AddButton(info, level)
			end
		else
			for i = 1, 4 do
				info.value = i;
				info.text = format(ITEM_QUALITY_COLORS[i-1].hex.."%s|r",(_G["BATTLE_PET_BREED_QUALITY"..i]))
				info.func = function()
								if _G["HPetAllInfoFramerarityButton"] then
									HPetAllInfoFramerarityButton:SetText(format(ITEM_QUALITY_COLORS[i-1].hex.."%s|r",(_G["BATTLE_PET_BREED_QUALITY"..i])))
								end
								HPetAllInfoFrame[name.."value"] = i
								HPetAllInfoFrame:Update(nil,nil,i)
							end
				UIDropDownMenu_AddButton(info, level)
			end
		end
	end
	UIDropDownMenu_Initialize(tempDropDown, tempDropDownInit, "MENU");

	local button=CreateFrame("Button",self:GetName()..name.."Button",HPetAllInfoFrame[name],"UIMenuButtonStretchTemplate")
	button:SetText(NONE)
	_G[button:GetName().."Left"]:SetAlpha(0.5)
	_G[button:GetName().."Right"]:SetAlpha(0.5)
	_G[button:GetName().."Middle"]:SetAlpha(0.5)
	button:SetAlpha(0.8)
	button:SetHeight(20)
	button:SetWidth(80)
	button.rightArrow:Show()
	button:SetPoint("CENTER",14,0)
	button:SetScript("OnClick",function()
		PlaySound("igMainMenuOptionCheckBoxOn");
		ToggleDropDownMenu(1, nil, tempDropDown, button, 60, 0);
	end)
	return button
end

function HPetAllInfoFrame:CreateTable(name,useTABLE,width,height,point,relative,repoint,h,x,y)
	local rt={}
	rt.index=#useTABLE
	rt.UpdateInfo=function(pet,breedID,level,rarity)
		local useline = true
		local selfheight = 0
		for i = h and 0 or 1, 20 do
			if pet and pet[4] and pet[4][i] then
				local h,p,s = HPetDate.GetBreedByID(pet[4][i])
				local info = {pet[4][i],{pet[1],h},{pet[2],p},{pet[3],s}}
				local light= breedID and (breedID==pet[4][i] or breedID-10==pet[4][i] or breedID+10==pet[4][i]) or nil

				rt["table"..i]:SetInfo(info,level,rarity,light)
				rt["table"..i]:Show()
				selfheight = selfheight + height
				if i == 1 then
					rt["table"..i].moveline:Show()
				elseif useline and pet[4][i]>12 then
					rt["table"..i].moveline:Show()
					useline	= false
				else
					rt["table"..i].moveline:Hide()
				end
			elseif i==1 then
				rt["table"..i]:SetInfo({"-","-","-","-"})
				rt["table"..i]:Show()
				selfheight = selfheight + height
			elseif pet and i==0 then
				rt["table"..i]:SetInfo({"",pet[1],pet[2],pet[3]})
				rt["table"..i]:Show()
				selfheight = selfheight + height
			else
				rt["table"..i]:Hide()
			end
		end
		return selfheight
	end
	rt.init=function()
		for i = h and 0 or 1, 20 do
			local tab=CreateFrame("Frame",name.."table"..i,self)
			local index=rt.index
			tab:SetSize(width,height)
			tab:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background"})

			tab:SetPoint(point,relative,repoint,(x or 0),height*(1-i) + (y or 0))

			---外框:
			HPetAllInfoFrame:CreateVLine(width/index*1, 0, -height, 1,LINECOLOR,tab)
			HPetAllInfoFrame:CreateVLine(width/index*2, 0, -height, 1,LINECOLOR,tab)
			HPetAllInfoFrame:CreateVLine(width/index*3, 0, -height, 1,LINECOLOR,tab)
--~ 			HPetAllInfoFrame:CreateVLine(width/index*4, 0, -height, 1,{1,1,0,1},tab)
			tab.moveline=HPetAllInfoFrame:CreateHLine(width, 0, 0, 1,LINECOLOR,tab)
			if i ~= 1 then tab.moveline:SetTexture(1,1,0,1) end
			HPetAllInfoFrame:CreateHLine(width, 0, -height, 1,LINECOLOR,tab)
			---内容:
			for k,v in pairs(useTABLE) do
				local font=tab:CreateFontString(HPetAllInfoFrame:GetName()..v,"OVERLAY","GameFontHighlight")
				tab[v] = font
				font:SetSize(width/index-5,height)
				font:SetJustifyH("RIGHT")
				font:SetPoint("LEFT",font:GetParent(),"LEFT",width/index*(k-1), 0)
			end

			tab.SetInfo = function(self,info,level,rarity,light)
				local qrarity=tonumber("1."..(rarity or 0)-1) or 0
				for k,v in pairs(useTABLE) do
					if level then
						if k == 1 then
							tab[v]:SetText(format("%.0f",(info[k+1][1]+info[k+1][2])*level*qrarity*5+100-0.05))
						else
							tab[v]:SetText(format("%.0f",(info[k+1][1]+info[k+1][2])*level*qrarity-0.05))
						end
					else
						if k == 1 or not tonumber(info[1]) then
							tab[v]:SetText(info[k])
						else
							if HPetAllInfoFrameSwitch.value then
								tab[v]:SetText(format("+%s",info[k][2]))
							else
								tab[v]:SetText(info[k][1]+info[k][2])
							end
						end
					end
					if light then
						tab[v]:SetShadowColor(0.41, 0.8, 0.94, 0.8)
					else
						tab[v]:SetShadowColor(0, 0, 0, 0)
					end
				end
				if light then
					tab:SetBackdropColor(1,0.96,0.41,0.8)
				else
					tab:SetBackdropColor(0,0,0,0)
				end
			end
			tab:Hide()
			rt["table"..i] = tab
		end
	end
	rt.height = width/4
	rt.init()
	return rt
end

function HPetAllInfoFrame:CreateVLine (x, y1, y2, w, color, parent)
  parent = parent or self
  local line = parent:CreateTexture (nil, "ARTWORK")
  line:SetDrawLayer ("ARTWORK")
  line:SetTexture (color[1], color[2], color[3], color[4])
  if y1 > y2 then
    y1, y2 = y2, y1
  end
  line:ClearAllPoints ()
  line:SetTexCoord (1, 0, 0, 0, 1, 1, 0, 1)
  line.width = w
  line:SetPoint ("BOTTOMLEFT", parent, "TOPLEFT", x - w / 2, y1)
  line:SetPoint ("TOPRIGHT", parent, "TOPLEFT", x + w / 2, y2)
  line:Show ()
  line.SetPos = function (self, x, y1, y2)
    if y1 > y2 then
      y1, y2 = y2, y1
    end
    self:ClearAllPoints ()
    self:SetPoint ("BOTTOMLEFT", parent, "TOPLEFT", x - self.width / 2, y1)
    self:SetPoint ("TOPRIGHT", parent, "TOPLEFT", x + self.width / 2, y2)
  end
  line:Show()
  return line
end

function HPetAllInfoFrame:CreateHLine (x1, x2, y, w, color, parent)
  parent = parent or self
  local line = parent:CreateTexture (nil, "ARTWORK")
  line:SetDrawLayer ("ARTWORK")
  line:SetTexture (color[1], color[2], color[3], color[4])
  if x1 > x2 then
    x1, x2 = x2, x1
  end
  line:ClearAllPoints ()
  line:SetTexCoord (0, 0, 0, 1, 1, 0, 1, 1)
  line.width = w
  line:SetPoint ("BOTTOMLEFT", parent, "TOPLEFT", x1, y - w / 2)
  line:SetPoint ("TOPRIGHT", parent, "TOPLEFT", x2, y + w / 2)
  line:Show ()
  line.SetPos = function (self, x1, x2, y)
    if x1 > x2 then
      x1, x2 = x2, x1
    end
    self:ClearAllPoints ()
    self:SetPoint ("BOTTOMLEFT", parent, "TOPLEFT", x1, y - self.width / 2)
    self:SetPoint ("TOPRIGHT", parent, "TOPLEFT", x2, y + self.width / 2)
  end
  line:Show()
  return line
end

function HPetAllInfoFrame:initframe(frames)
	for key,value in pairs(frames) do
		self[value.name]=CreateFrame("Frame",self:GetName()..value.name,self,value.inherits or nil)
		self[value.name]:SetSize(value.width,value.height)
		self[value.name]:SetBackdrop(backdrop);
		if value.point then
			if value.relative then
				value.relative = self:GetName()..value.relative
			end
			self[value.name]:SetPoint(value.point,value.relative or self,value.repoint or self.point,value.x or 0,value.y or 0)
		end
		if value.font then
			self[value.name].text=self[value.name]:CreateFontString(self:GetName().."text","OVERLAY","GameFontHighlight")
			self[value.name].text:SetFont(GameFontHighlight:GetFont(), value.font.size or 15)
			if value.font.point then
				self[value.name].text:SetPoint(value.font.point,10,0)
			else
				self[value.name].text:SetPoint("CENTER")
			end
			if value.font.text then
				self[value.name].text:SetText(value.font.text)
			end
		end
		if value.texture then
			self[value.name].icon=self[value.name]:CreateTexture(self:GetName().."icon","OVERLAY")
			if value.texture.size then
				self[value.name].icon:SetSize(value.texture.size,value.texture.size)
			else
				self[value.name].icon:SetSize(16,16)
			end
			if value.texture.point then
				self[value.name].icon:SetPoint(value.texture.point,self[value.name].text,value.texture.repoint)
			else
				self[value.name].icon:SetPoint("CENTER")
			end
			if value.texture.icon then
				self[value.name].icon:SetTexture(value.texture.icon)
			end
			if value.texture.coords then
				self[value.name].icon:SetTexCoord(value.texture.coords[1],value.texture.coords[2],value.texture.coords[3],value.texture.coords[4])
			end
		end
	end
end

function HPetAllInfoFrame:Open(...)
	if not self.ready then self:Init() end
	if not self:IsShown() then self:Show() else self:Hide() end
	self:Update(...)
end
