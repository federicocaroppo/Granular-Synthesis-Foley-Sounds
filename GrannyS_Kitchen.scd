(

s.waitForBoot({

var window,scale,width,height,maxWidth,maxHeight,backG,figWidht,figHeight;
var marginW,marginH,margin1H,margin2H,margin2W,margin3W,margin3H,marginSH,box1W,box1H,box2W,box2H,box3W,box3H,scopeH;
var box1, box2, box3, box4;
var slider1_1,slider1_2,slider2_1,slider2_2,slider3_1,slider3_2,slider4_1,slider4_2;
var button_1_1_1,knob_1_1_2,knob_1_1_3,knob_1_1_4,button_2_1_1,knob_2_1_2,knob_2_1_3,knob_2_1_4,button_3_1_1,knob_3_1_2,knob_3_1_3,knob_3_1_4,button_4_1_1,knob_4_1_2,knob_4_1_3,knob_4_1_4;
var knob_1_2_1,knob_1_2_2,knob_1_2_3,knob_1_2_4,knob_2_2_1,knob_2_2_2,knob_2_2_3,knob_2_2_4,knob_3_2_1,knob_3_2_2,knob_3_2_3,knob_3_2_4,knob_4_2_1,knob_4_2_2,knob_4_2_3,knob_4_2_4;
var box1_1,box1_2,box1_3,box2_1,box2_2,box2_3,box3_1,box3_2,box3_3,box4_1,box4_2,box4_3;
var subTitle1,subTitle2,subTitle3,subTitle4;
var icon1,icon2,icon3,icon4,logo;
var scope1,scope2,scope3,scope4;
var freq1,freq2,freq3,freq4;
var buttonScope1,buttonScope2,buttonScope3,buttonScope4;
var fontS,fontL;
var displacement,boxn;
var incr;
var play1,play2,play3,play4;
var f1, f2, f3, f4;
var busNum;


busNum=4;

//setup
~b3 = Buffer.readChannel(s, thisProcess.nowExecutingPath.dirname +/+ "/Songs/Le_festin_no_intro.mp3");
//~b3.play;




//---------------------------------------GAS---------------------------------------------
SynthDef.new("rat1", {

	arg amp=1,mix=0.2,room=0.3,damp=1,pan=0,rat=0.5,tickSpeed=0.5, pos=0.5;

	var sig, env,
	sig1, amp1=0.5,
	sig2, amp2=0.5, env2,
	sig3, amp3=0.9, env3, env31,
	sig4, amp4=1, env4;

	sig1=GrainBuf.ar(
		numChannels: 2,
		trigger: Dust.ar(1469.89),
		dur: 0.04912,
		sndbuf: ~b3,
		rate: 1.89+((rat*2)-1),
		pos: 0.00000,
		interp: 2,
		pan: pan,
		envbufnum: -1,
		maxGrains: 512);

	sig2=GrainBuf.ar(
		numChannels: 2,
		trigger: Dust.ar(4000),
		dur: 0.00000,
		sndbuf: ~b3,
		rate: 0,
		pos: 0.28855,
		interp: 2,
		pan: pan,
		envbufnum: -1,
		maxGrains: 512);

		env2 =  EnvGen.ar(Env([0, 1, 0], [0.005, 0.015], curve: 0), Impulse.kr(2*tickSpeed*2));
	// [0.005, 0.015] definisce la durata dei tick
	// 1/0.5 è la frequenza con cui si riproducono i tick

	sig3=GrainBuf.ar(
		numChannels: 2,
		trigger: Dust.ar(388),
		dur: 0.00391,
		sndbuf: ~b3,
		rate: 0.29+((rat*0.4)-0.2),
		pos: 0.16565+((pos*2)-1),
		interp: 2,
		pan: pan,
		envbufnum: -1,
		maxGrains: 512);

	env3 = LFPulse.ar(0.08, 0.8, 0.8);
	// env 3 parte da 0 e passa 1, questo gestice il passaggio dai tick al gas acceso
	env31= LFPulse.ar(0.08, 0.79, 0.79);

	sig4=GrainBuf.ar(
		numChannels: 2,
		trigger: Dust.ar(388),
		dur: 0.01291,
		sndbuf: ~b3,
		rate: 0.30,
		pos: 0.16565+((pos*2)-1),
		interp: 2,
		pan: pan,
		envbufnum: -1,
		maxGrains: 512);

	env4=EnvGen.ar(Env([1, 0], [0.7], curve: 0), env3);

	sig=(sig1*amp1)+(sig2*amp2*env2*(1-env31))+(sig3*amp3*env3)+(sig4*amp4*env4*env3);


	//env =  EnvGen.ar(Env([0, 1, 0], [0.005, 1/0.001], curve: [0, 500]), 1, 1, 0, 1, 1);
	//questo env ha il solo scopo di far suonare il sample solo una volta e poi liberare tutti i synth

	Out.ar(busNum, FreeVerb.ar(sig, mix, room, damp)*amp);

}).add;

//

//PLAY GAS
//synth1 = Synth.new(\rat1);



//---------------------------------------KNIFE---------------------------------------------
SynthDef.new("rat2", {

		arg amp=1, mix=0.2, room=0.3,damp=1,pan=0,tickSpeed=0.5, rat=0.5, pos=1;

	var sig, env,
	sig1, amp1=1,
	sig2, amp2=2.5, env2;

	sig1=GrainBuf.ar(
		numChannels: 2,
		trigger: Impulse.ar(0.5+tickSpeed),
		dur: 0.35,
		sndbuf: ~b3,
		rate: 0.5+((rat*0.4)-0.2),
		pos: 0.27,
		interp: 2,
		pan: pan,
		envbufnum: -1,
		maxGrains: 512);

	sig2=GrainBuf.ar(
		numChannels: 2,
		trigger: Impulse.ar(0.5+tickSpeed, 0.87),
		dur: 0.02524,
		sndbuf: ~b3,
		rate: 0.23+((rat*0.2)-0.1),
		pos: 0.95064-(pos*0.2),
		interp: 2,
		pan: pan,
		envbufnum: -1,
		maxGrains: 512);

	//env2 = EnvGen.ar(Env([0, 1, 0], [0.005, 0.055], curve: 0), Impulse.kr(1, 0.75));

	sig = (sig1*amp1) + (sig2*amp2);

	//env = EnvGen.ar(Env([1, 0], [4], curve: [500]), 1, 1, 0, 1, 1);

		Out.ar(busNum+2, FreeVerb.ar(sig, mix, room, damp)*amp);//*env);

}).add;


//PLAY KNIFE
//{var aSynth = Synth.new(\rat2);}.play;



//---------------------------------------GLASS---------------------------------------------
SynthDef.new("rat3", {

		arg mix=0.2, amp=1, room=0.3,damp=1,pan=0,rat=0.5,len=0.5, pos=1;

	var sig, env, env1, panner,rev, pitch=((rat)+0.5), length=((len*8)-4);

	sig=GrainBuf.ar(
		numChannels: 2,
		trigger: Impulse.ar(319.09),
		dur: 0.09134,
		sndbuf: ~b3,
		rate: 1.61,
		pos: 0.17028+((pos*0.05)-0.025),
		interp: 2,
		pan: pan,
		envbufnum: -1,
		maxGrains: 512);

		env1 =  EnvGen.ar(Env([1, 0], [0.03], curve: [500]), 1, 1, 0, 1, 0);

		sig = DynKlank.ar(`[[800*1.2*pitch, 2684*1.2*pitch, 4612*1.2*pitch, 6892*1.2*pitch], [1, 0.25, 0.165, 0.0625], [5+length, 4+(length/2), 3+(length/3), 2+(length/4)]], sig*env1*0.1);
	rev = FreeVerb.ar(sig, mix, room, damp);
	panner = Pan2.ar(rev*amp,pan);

	env =  EnvGen.ar(Env([1, 0], [6+length], curve: [-5]), 1, 1, 0, 1, 2);

		Out.ar(busNum+(2*2), panner);

}).add;


//PLAY GLASS
//{var aSynth = Synth.new(\rat3);}.play;
//PLAY GLASS


/*r=Routine.new({
  inf.do({
			var aSynth = Synth.new(\rat3,[\amp,slider3_1.value/100,\pan,slider3_2.value]);
    4.wait;
  });
});
*/

//---------------------------------------BOILING WATER--------------------------------------------
SynthDef.new("rat4", {

		arg amp=0.7, mix=0.2,room=0.3,damp=1,pan=0, rat=0.5, pos=0.5, dens=0.5;

	var sig, env,
	sig1, amp1=1,
	sig2, amp2=1,
	sig3, amp3=1,
	sig4, amp4=0.7;

	sig1=GrainBuf.ar(
		numChannels: 2,
		trigger: Dust.ar(20+((dens*40)-20)),
		dur: 0.01751,
		sndbuf: ~b3,
		rate: 1+((rat*1)-0.5),
		pos: 0.06094+((pos*0.1)-0.05),
		interp: 2,
		pan: pan,
		envbufnum: -1,
		maxGrains: 512);

	sig2=GrainBuf.ar(
		numChannels: 2,
		trigger: Dust.ar(10+((dens*20)-10)),
		dur: 0.01751,
		sndbuf: ~b3,
		rate: 2+((rat*2)-1),
		pos: 0.16094+((pos*0.2)-0.1),
		interp: 2,
		pan: pan,
		envbufnum: -1,
		maxGrains: 512);

	sig3=GrainBuf.ar(
		numChannels: 2,
		trigger: Dust.ar(30+((dens*60)-30)),
		dur: 0.01751,
		sndbuf: ~b3,
		rate: 3+((rat*3)-1.5),
		pos: 0.26094+((pos*0.2)-0.1),
		interp: 2,
		pan: pan,
		envbufnum: -1,
		maxGrains: 512);

	sig4=GrainBuf.ar(
		numChannels: 2,
		trigger: Dust.ar(855),
		dur: 0.01234,
		sndbuf: ~b3,
		rate: 9.613+((rat*3)-1.5),
		pos: 0.31664,
		interp: 2,
		pan: pan,
		envbufnum: -1,
		maxGrains: 512);

	sig = (sig1*amp1)+(sig2*amp2)+(sig3*amp3)+(sig4*amp4);

	//env =  EnvGen.ar(Env([1, 0], [5], curve: [500]), 1, 1, 0, 1, 1);

	Out.ar(busNum+(3*2), FreeVerb.ar(sig, mix, room, damp)*amp*0.25);//*env);

}).add;


//PLAY BOILING WATER
//{var aSynth = Synth.new(\rat4);}.play;

//GUI

Window.closeAll;

backG = Image.new(thisProcess.nowExecutingPath.dirname +/+ "Images/GUIv0.2Plain_NoInterface.png");
icon1 = Image.new(thisProcess.nowExecutingPath.dirname +/+ "Images/Stove2");
icon2 = Image.new(thisProcess.nowExecutingPath.dirname +/+ "Images/Onions2");
icon3 = Image.new(thisProcess.nowExecutingPath.dirname +/+ "Images/Cheers2");
icon4 = Image.new(thisProcess.nowExecutingPath.dirname +/+ "Images/Kettle");
logo = Image.new(thisProcess.nowExecutingPath.dirname +/+ "Images/GrannySLogo2");

scale = 1.25;

maxWidth = Window.screenBounds.width;
maxHeight = Window.screenBounds.height;
width = maxWidth/scale;
height = maxHeight/scale;
	window = Window.new("Granny",Rect.new((maxWidth-width)/2,(maxHeight-height)/2,width,height),resizable:false).front.alwaysOnTop_(true);
window.view.setBackgroundImage(backG,10);

window.onClose = {
		~play1.stop;
		s.freeAll;
	};

incr = 200; //IF DIFFERENT BACKGROUND, CHANGE THIS VALUE TO REPLACE CORRECTLY ALL THE GUI ELEMENTS.
            //GUIv0.2 -> incr = 200;
            //GUIv0.1 -> incr = 0;

marginW = (width/backG.width)*27;
marginH = (height/backG.height)*(225+incr);

box1W = width - (5 * (marginW))/4;
box1H = (height/backG.height)*156;

margin1H = (height/backG.height)*(650+incr)-box1H;

margin2H = (height/backG.height)*(680+incr);
margin2W = marginW+(box1W/36)+(box1W/48);
margin3W = margin2W+(box1W/4.5);
margin3H = (height/backG.height)*(360+incr);

marginSH = (height/backG.height)*(1002+incr);

scopeH = (height/backG.height)*200;

box2W = box1W;
box2H = box1H;
box3W = box2W-(box2W/36)-(box1W/4.5);
boxn = 0;

fontS = height/17;
fontL = height/45;

displacement = box1W+marginW;

window.drawFunc = {
	//Pen.addRect(w.view.bounds.insetBy(0));
	Pen.drawImage(Rect(margin2W-5, margin3H-30, box2H,box2H), icon1, operation: 'sourceOver');
	Pen.drawImage(Rect(margin2W-5+ displacement, margin3H-30, box2H,box2H), icon2, operation: 'sourceOver');
	Pen.drawImage(Rect(margin2W-5+(2* displacement), margin3H-30, box2H,box2H), icon3, operation: 'sourceOver');
	Pen.drawImage(Rect(margin2W-5+(3* displacement), margin3H-30, box2H,box2H), icon4, operation: 'sourceOver');
	Pen.drawImage(Rect(width/3, marginH/10, width/3,marginH), logo, operation: 'sourceOver');
};

box1_1 = FlowView.new(window,Rect(margin2W,margin1H,box1W-(box1W/36),box1H));
box1_2 = FlowView.new(window,Rect(margin2W,margin2H,box2W-(box2W/36),box2H));
box1_3 = FlowView.new(window,Rect(margin3W,margin3H,box3W,box2H));

subTitle1 = StaticText.new(window,Rect(marginW,marginH,box1W,box1H)).string_("Stove").align_(\center).font_(Font("Monotype Corsiva", fontS));

button_1_1_1 = Button.new(box1_1,Rect(0,0,box1W/4.5,box1H/2)).states_([["Play",Color.white,Color.black],["Stop",Color.red,Color.black]]).font_(Font("Monotype Corsiva", fontL));
knob_1_1_2 = EZKnob(box1_1,box1W/4.5@box1H,"Dry/Wet",layout:\vert2,labelHeight:box1H/4,initVal:0.2);
knob_1_1_3 = EZKnob(box1_1,box1W/4.5@box1H,"Room",layout:\vert2,labelHeight:box1H/4,initVal:0.3);
knob_1_1_4 = EZKnob(box1_1,box1W/4.5@box1H,"Damp",layout:\vert2,labelHeight:box1H/4,initVal:1);

//knob_1_2_1 = EZKnob(box1_2,box2W/4.5@box2H,"Size",layout:\vert2,labelHeight:box1H/4);
knob_1_2_2 = EZKnob(box1_2,box2W/3.5@box2H,"Ticks",layout:\vert2,labelHeight:box1H/4,initVal:0.5);
knob_1_2_3 = EZKnob(box1_2,box2W/3.5@box2H,"Pos",layout:\vert2,labelHeight:box1H/4,initVal:0.5);
knob_1_2_4 = EZKnob(box1_2,box2W/3.5@box2H,"Pitch",layout:\vert2,labelHeight:box1H/4,initVal:0.5);

slider1_1 = EZSlider(box1_3,box3W*0.935@(box2H/4),"Volume",ControlSpec(0,100,step:1),labelHeight:box1H/4,numberWidth:box3W/8,initVal:100);
box1_3.startRow;
box1_3.startRow;
slider1_2 = EZSlider(box1_3,box3W*0.935@(box2H/4),"Pan",ControlSpec(-1.0,1.0),initVal:0.0,labelHeight:box1H/4,numberWidth:box3W/8);

knob_1_1_2.setColors(numNormalColor:Color.white,numBackground:Color.black,knobColors:[nil,nil,Color.fromHexString("#d4d4d4"),Color.white]).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);
knob_1_1_3.setColors(numNormalColor:Color.white,numBackground:Color.black,knobColors:[nil,nil,Color.fromHexString("#d4d4d4"),Color.white]).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);
knob_1_1_4.setColors(numNormalColor:Color.white,numBackground:Color.black,knobColors:[nil,nil,Color.fromHexString("#d4d4d4"),Color.white]).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);

//knob_1_2_1.setColors(numBackground:Color.fromHexString("#4c647b"),numNormalColor: Color.fromHexString("#d4af37"),stringColor: Color.fromHexString("#d4af37"),knobColors:[Color.fromHexString("#d7c286"),Color.fromHexString("#d7c286"),Color.fromHexString("#d4d4d4"),nil]).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);
knob_1_2_2.setColors(numBackground:Color.fromHexString("#4c647b"),numNormalColor: Color.fromHexString("#d4af37"),stringColor: Color.fromHexString("#d4af37"),knobColors:[Color.fromHexString("#d7c286"),Color.fromHexString("#d7c286"),Color.fromHexString("#d4d4d4"),nil]).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);
knob_1_2_3.setColors(numBackground:Color.fromHexString("#4c647b"),numNormalColor: Color.fromHexString("#d4af37"),stringColor: Color.fromHexString("#d4af37"),knobColors:[Color.fromHexString("#d7c286"),Color.fromHexString("#d7c286"),Color.fromHexString("#d4d4d4"),nil]).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);
knob_1_2_4.setColors(numBackground:Color.fromHexString("#4c647b"),numNormalColor: Color.fromHexString("#d4af37"),stringColor: Color.fromHexString("#d4af37"),knobColors:[Color.fromHexString("#d7c286"),Color.fromHexString("#d7c286"),Color.fromHexString("#d4d4d4"),nil]).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);

slider1_1.setColors(numNormalColor:Color.white,sliderBackground:Color.black,numBackground:Color.black).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);
slider1_2.setColors(numNormalColor:Color.white,sliderBackground:Color.black,numBackground:Color.black).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);

boxn=1;

box2_1 = FlowView.new(window,Rect(margin2W+(boxn*displacement),margin1H,box1W-(box1W/36),box1H));
box2_2 = FlowView.new(window,Rect(margin2W+(boxn*displacement),margin2H,box2W-(box2W/36),box2H));
box2_3 = FlowView.new(window,Rect(margin3W+(boxn*displacement),margin3H,box3W,box2H));

subTitle2 = StaticText.new(window,Rect(marginW+(boxn*displacement),marginH,box1W,box1H)).string_("Onions").align_(\center).font_(Font("Monotype Corsiva", fontS));

button_2_1_1 = Button.new(box2_1,Rect(0,0,box1W/4.5,box1H/2)).states_([["Play",Color.white,Color.black],["Stop",Color.red,Color.black]]).font_(Font("Monotype Corsiva", fontL));
knob_2_1_2 = EZKnob(box2_1,box1W/4.5@box1H,"Dry/Wet",layout:\vert2,labelHeight:box1H/4,initVal:0.2);
knob_2_1_3 = EZKnob(box2_1,box1W/4.5@box1H,"Room",layout:\vert2,labelHeight:box1H/4,initVal:0.3);
knob_2_1_4 = EZKnob(box2_1,box1W/4.5@box1H,"Damp",layout:\vert2,labelHeight:box1H/4,initVal:1);

//knob_2_2_1 = EZKnob(box2_2,box2W/4.5@box2H,"Size",layout:\vert2,labelHeight:box1H/4);
knob_2_2_2 = EZKnob(box2_2,box2W/3.5@box2H,"Ticks",layout:\vert2,labelHeight:box1H/4,initVal:0.5);
knob_2_2_3 = EZKnob(box2_2,box2W/3.5@box2H,"Pos",layout:\vert2,labelHeight:box1H/4,initVal:1);
knob_2_2_4 = EZKnob(box2_2,box2W/3.5@box2H,"Pitch",layout:\vert2,labelHeight:box1H/4,initVal:0.5);

slider2_1 = EZSlider(box2_3,box3W*0.935@(box2H/4),"Volume",ControlSpec(0,100,step:1),labelHeight:box1H/4,numberWidth:box3W/8,initVal:100);
box2_3.startRow;
box2_3.startRow;
slider2_2 = EZSlider(box2_3,box3W*0.935@(box2H/4),"Pan",ControlSpec(-1.0,1.0),initVal:0.0,labelHeight:box1H/4,numberWidth:box3W/8);

knob_2_1_2.setColors(numNormalColor:Color.white,numBackground:Color.black,knobColors:[nil,nil,Color.fromHexString("#d4d4d4"),Color.white]).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);
knob_2_1_3.setColors(numNormalColor:Color.white,numBackground:Color.black,knobColors:[nil,nil,Color.fromHexString("#d4d4d4"),Color.white]).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);
knob_2_1_4.setColors(numNormalColor:Color.white,numBackground:Color.black,knobColors:[nil,nil,Color.fromHexString("#d4d4d4"),Color.white]).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);

//knob_2_2_1.setColors(numBackground:Color.fromHexString("#4c647b"),numNormalColor: Color.fromHexString("#d4af37"),stringColor: Color.fromHexString("#d4af37"),knobColors:[Color.fromHexString("#d7c286"),Color.fromHexString("#d7c286"),Color.fromHexString("#d4d4d4"),nil]).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);
knob_2_2_2.setColors(numBackground:Color.fromHexString("#4c647b"),numNormalColor: Color.fromHexString("#d4af37"),stringColor: Color.fromHexString("#d4af37"),knobColors:[Color.fromHexString("#d7c286"),Color.fromHexString("#d7c286"),Color.fromHexString("#d4d4d4"),nil]).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);
knob_2_2_3.setColors(numBackground:Color.fromHexString("#4c647b"),numNormalColor: Color.fromHexString("#d4af37"),stringColor: Color.fromHexString("#d4af37"),knobColors:[Color.fromHexString("#d7c286"),Color.fromHexString("#d7c286"),Color.fromHexString("#d4d4d4"),nil]).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);
knob_2_2_4.setColors(numBackground:Color.fromHexString("#4c647b"),numNormalColor: Color.fromHexString("#d4af37"),stringColor: Color.fromHexString("#d4af37"),knobColors:[Color.fromHexString("#d7c286"),Color.fromHexString("#d7c286"),Color.fromHexString("#d4d4d4"),nil]).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);

slider2_1.setColors(numNormalColor:Color.white,sliderBackground:Color.black,numBackground:Color.black).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);
slider2_2.setColors(numNormalColor:Color.white,sliderBackground:Color.black,numBackground:Color.black).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);

boxn=2;

box3_1 = FlowView.new(window,Rect(margin2W+(boxn*displacement),margin1H,box1W-(box1W/36),box1H));
box3_2 = FlowView.new(window,Rect(margin2W+(boxn*displacement),margin2H,box2W-(box2W/36),box2H));
box3_3 = FlowView.new(window,Rect(margin3W+(boxn*displacement),margin3H,box3W,box2H));

subTitle3 = StaticText.new(window,Rect(marginW+(boxn*displacement),marginH,box1W,box1H)).string_("Cheers").align_(\center).font_(Font("Monotype Corsiva", fontS));

button_3_1_1 = Button.new(box3_1,Rect(0,0,box1W/4.5,box1H/2)).states_([["Play",Color.white,Color.black]]).font_(Font("Monotype Corsiva", fontL));
knob_3_1_2 = EZKnob(box3_1,box1W/4.5@box1H,"Dry/Wet",layout:\vert2,labelHeight:box1H/4,initVal:0.2);
knob_3_1_3 = EZKnob(box3_1,box1W/4.5@box1H,"Room",layout:\vert2,labelHeight:box1H/4,initVal:0.3);
knob_3_1_4 = EZKnob(box3_1,box1W/4.5@box1H,"Damp",layout:\vert2,labelHeight:box1H/4,initVal:1);

//knob_3_2_1 = EZKnob(box3_2,box2W/4.5@box2H,"Size",layout:\vert2,labelHeight:box1H/4);
knob_3_2_2 = EZKnob(box3_2,box2W/3.5@box2H,"Dur",layout:\vert2,labelHeight:box1H/4,initVal:0.5);
knob_3_2_3 = EZKnob(box3_2,box2W/3.5@box2H,"Pos",layout:\vert2,labelHeight:box1H/4,initVal:0.5);
knob_3_2_4 = EZKnob(box3_2,box2W/3.5@box2H,"Pitch",layout:\vert2,labelHeight:box1H/4,initVal:0.5);

slider3_1 = EZSlider(box3_3,box3W*0.935@(box2H/4),"Volume",ControlSpec(0,100,step:1),labelHeight:box1H/4,numberWidth:box3W/8,initVal:100);
box3_3.startRow;
box3_3.startRow;
slider3_2 = EZSlider(box3_3,box3W*0.935@(box2H/4),"Pan",ControlSpec(-1.0,1.0),initVal:0.0,labelHeight:box1H/4,numberWidth:box3W/8);

knob_3_1_2.setColors(numNormalColor:Color.white,numBackground:Color.black,knobColors:[nil,nil,Color.fromHexString("#d4d4d4"),Color.white]).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);
knob_3_1_3.setColors(numNormalColor:Color.white,numBackground:Color.black,knobColors:[nil,nil,Color.fromHexString("#d4d4d4"),Color.white]).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);
knob_3_1_4.setColors(numNormalColor:Color.white,numBackground:Color.black,knobColors:[nil,nil,Color.fromHexString("#d4d4d4"),Color.white]).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);

//knob_3_2_1.setColors(numBackground:Color.fromHexString("#4c647b"),numNormalColor: Color.fromHexString("#d4af37"),stringColor: Color.fromHexString("#d4af37"),knobColors:[Color.fromHexString("#d7c286"),Color.fromHexString("#d7c286"),Color.fromHexString("#d4d4d4"),nil]).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);
knob_3_2_2.setColors(numBackground:Color.fromHexString("#4c647b"),numNormalColor: Color.fromHexString("#d4af37"),stringColor: Color.fromHexString("#d4af37"),knobColors:[Color.fromHexString("#d7c286"),Color.fromHexString("#d7c286"),Color.fromHexString("#d4d4d4"),nil]).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);
knob_3_2_3.setColors(numBackground:Color.fromHexString("#4c647b"),numNormalColor: Color.fromHexString("#d4af37"),stringColor: Color.fromHexString("#d4af37"),knobColors:[Color.fromHexString("#d7c286"),Color.fromHexString("#d7c286"),Color.fromHexString("#d4d4d4"),nil]).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);
knob_3_2_4.setColors(numBackground:Color.fromHexString("#4c647b"),numNormalColor: Color.fromHexString("#d4af37"),stringColor: Color.fromHexString("#d4af37"),knobColors:[Color.fromHexString("#d7c286"),Color.fromHexString("#d7c286"),Color.fromHexString("#d4d4d4"),nil]).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);

slider3_1.setColors(numNormalColor:Color.white,sliderBackground:Color.black,numBackground:Color.black).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);
slider3_2.setColors(numNormalColor:Color.white,sliderBackground:Color.black,numBackground:Color.black).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);

boxn=3;

box4_1 = FlowView.new(window,Rect(margin2W+(boxn*displacement),margin1H,box1W-(box1W/36),box1H));
box4_2 = FlowView.new(window,Rect(margin2W+(boxn*displacement),margin2H,box2W-(box2W/36),box2H));
box4_3 = FlowView.new(window,Rect(margin3W+(boxn*displacement),margin3H,box3W,box2H));

subTitle4 = StaticText.new(window,Rect(marginW+(boxn*displacement),marginH,box1W,box1H)).string_("Kettle").align_(\center).font_(Font("Monotype Corsiva", fontS));

button_4_1_1 = Button.new(box4_1,Rect(0,0,box1W/4.5,box1H/2)).states_([["Play",Color.white,Color.black],["Stop",Color.red,Color.black]]).font_(Font("Monotype Corsiva", fontL));
knob_4_1_2 = EZKnob(box4_1,box1W/4.5@box1H,"Dry/Wet",layout:\vert2,labelHeight:box1H/4,initVal:0.2);
knob_4_1_3 = EZKnob(box4_1,box1W/4.5@box1H,"Room",layout:\vert2,labelHeight:box1H/4,initVal:0.3);
knob_4_1_4 = EZKnob(box4_1,box1W/4.5@box1H,"Damp",layout:\vert2,labelHeight:box1H/4,initVal:1);

//knob_4_2_1 = EZKnob(box4_2,box2W/4.5@box2H,"Size",layout:\vert2,labelHeight:box1H/4);
knob_4_2_2 = EZKnob(box4_2,box2W/3.5@box2H,"Dens",layout:\vert2,labelHeight:box1H/4,initVal:0.5);
knob_4_2_3 = EZKnob(box4_2,box2W/3.5@box2H,"Pos",layout:\vert2,labelHeight:box1H/4,initVal:0.5);
knob_4_2_4 = EZKnob(box4_2,box2W/3.5@box2H,"Pitch",layout:\vert2,labelHeight:box1H/4,initVal:0.5);

slider4_1 = EZSlider(box4_3,box3W*0.935@(box2H/4),"Volume",ControlSpec(0,100,step:1),labelHeight:box1H/4,numberWidth:box3W/8,initVal:100);
box4_3.startRow;
box4_3.startRow;
slider4_2 = EZSlider(box4_3,box3W*0.935@(box2H/4),"Pan",ControlSpec(-1.0,1.0),initVal:0.0,labelHeight:box1H/4,numberWidth:box3W/8);

knob_4_1_2.setColors(numNormalColor:Color.white,numBackground:Color.black,knobColors:[nil,nil,Color.fromHexString("#d4d4d4"),Color.white]).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);
knob_4_1_3.setColors(numNormalColor:Color.white,numBackground:Color.black,knobColors:[nil,nil,Color.fromHexString("#d4d4d4"),Color.white]).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);
knob_4_1_4.setColors(numNormalColor:Color.white,numBackground:Color.black,knobColors:[nil,nil,Color.fromHexString("#d4d4d4"),Color.white]).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);

//knob_4_2_1.setColors(numBackground:Color.fromHexString("#4c647b"),numNormalColor: Color.fromHexString("#d4af37"),stringColor: Color.fromHexString("#d4af37"),knobColors:[Color.fromHexString("#d7c286"),Color.fromHexString("#d7c286"),Color.fromHexString("#d4d4d4"),nil]).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);
knob_4_2_2.setColors(numBackground:Color.fromHexString("#4c647b"),numNormalColor: Color.fromHexString("#d4af37"),stringColor: Color.fromHexString("#d4af37"),knobColors:[Color.fromHexString("#d7c286"),Color.fromHexString("#d7c286"),Color.fromHexString("#d4d4d4"),nil]).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);
knob_4_2_3.setColors(numBackground:Color.fromHexString("#4c647b"),numNormalColor: Color.fromHexString("#d4af37"),stringColor: Color.fromHexString("#d4af37"),knobColors:[Color.fromHexString("#d7c286"),Color.fromHexString("#d7c286"),Color.fromHexString("#d4d4d4"),nil]).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);
knob_4_2_4.setColors(numBackground:Color.fromHexString("#4c647b"),numNormalColor: Color.fromHexString("#d4af37"),stringColor: Color.fromHexString("#d4af37"),knobColors:[Color.fromHexString("#d7c286"),Color.fromHexString("#d7c286"),Color.fromHexString("#d4d4d4"),nil]).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);

slider4_1.setColors(numNormalColor:Color.white,sliderBackground:Color.black,numBackground:Color.black).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);
slider4_2.setColors(numNormalColor:Color.white,sliderBackground:Color.black,numBackground:Color.black).font_(Font("Monotype Corsiva", fontL)).numberView.align_(\center);



scope1 = ScopeView.new(window,Rect(margin2W+(box1W/4.5),marginSH,box1W/2,scopeH));
scope1.background_(Color.black);
scope1.waveColors_([Color.fromHexString("#d7c286"), Color.fromHexString("#d7c286")]);
scope1.style_(0);
f1 = Buffer.alloc(s, 8092, 2);
scope1.bufnum = f1.bufnum;
scope1.server_(s);
scope1.start;
scope1.yZoom=6;

	scope2 = ScopeView.new(window,Rect(margin2W+(box1W/4.5)+(box1W+marginW),marginSH,box1W/2,scopeH));
scope2.background_(Color.black);
scope2.waveColors_([Color.fromHexString("#d7c286"), Color.fromHexString("#d7c286")]);
scope2.style_(0);
f2= Buffer.alloc(s, 8092, 2);
scope2.bufnum = f2.bufnum;
scope2.server_(s);
scope2.start;
scope2.yZoom=4;

scope3 = ScopeView.new(window,Rect(margin2W+(box1W/4.5)+(2*(box1W+marginW)),marginSH,box1W/2,scopeH));
scope3.background_(Color.black);
scope3.waveColors_([Color.fromHexString("#d7c286"), Color.fromHexString("#d7c286")]);
scope3.style_(0);
f3 = Buffer.alloc(s, 8092, 2);
scope3.bufnum = f3.bufnum;
scope3.server_(s);
scope3.start;
scope3.yZoom=12;

scope4 = ScopeView.new(window,Rect(margin2W+(box1W/4.5)+(3*(box1W+marginW)),marginSH,box1W/2,scopeH));
scope4.background_(Color.black);
scope4.waveColors_([Color.fromHexString("#d7c286"), Color.fromHexString("#d7c286")]);
scope4.style_(0);
f4 = Buffer.alloc(s, 8092, 2);
scope4.bufnum = f4.bufnum;
scope4.server_(s);
scope4.start;
scope4.yZoom=2;

buttonScope1 = Button.new(window,Rect(margin2W+(box1W/9.5),marginSH,box1W/9.5,box1H/4)).states_([["t",Color.black,Color.fromHexString("#d4af37")],["f",Color.black,Color.fromHexString("#d4af37")]]).font_(Font("Monotype Corsiva", fontL));

buttonScope1.action_({
		if(buttonScope1.value == 1){
			{scope1.stop;
			freq1 = FreqScopeView.new(window, Rect(margin2W+(box1W/4.5),marginSH,box1W/2,scopeH), s);
			freq1.freqMode_(1);
			freq1.inBus_(busNum);
			freq1.server_(s);
			freq1.active_(true);
			freq1.scope.visible = true;
			freq1.background_(Color.black);
			freq1.waveColors_([Color.fromHexString("#d4af37")])}.defer(0.2);
		};
		if(buttonScope1.value == 0){
			{freq1.active_(false);
			freq1.scope.visible = false;
			freq1.kill;
			scope1.start}.defer(0.2);
		};
	});

buttonScope2 = Button.new(window,Rect(margin2W+(box1W/9.5)+(1*(box1W+marginW)),marginSH,box1W/9.5,box1H/4)).states_([["t",Color.black,Color.fromHexString("#d4af37")],["f",Color.black,Color.fromHexString("#d4af37")]]).font_(Font("Monotype Corsiva", fontL));

buttonScope2.action_({
		if(buttonScope2.value == 1){
			{scope2.stop;
			freq2 = FreqScopeView.new(window, Rect(margin2W+(box1W/4.5)+(1*(box1W+marginW)),marginSH,box1W/2,scopeH), s);
			freq2.freqMode_(1);
			freq2.inBus_(busNum+2);
			freq2.server_(s);
			freq2.active_(true);
			freq2.scope.visible = true;
			freq2.background_(Color.black);
			freq2.waveColors_([Color.fromHexString("#d4af37")])}.defer(0.2);
		};
		if(buttonScope2.value == 0){
			{freq2.active_(false);
			freq2.scope.visible = false;
			freq2.kill;
			scope2.start}.defer(0.2);
		};
	});

buttonScope3 = Button.new(window,Rect(margin2W+(box1W/9.5)+(2*(box1W+marginW)),marginSH,box1W/9.5,box1H/4)).states_([["t",Color.black,Color.fromHexString("#d4af37")],["f",Color.black,Color.fromHexString("#d4af37")]]).font_(Font("Monotype Corsiva", fontL));

buttonScope3.action_({
		if(buttonScope3.value == 1){
			{scope3.stop;
			freq3 = FreqScopeView.new(window, Rect(margin2W+(box1W/4.5)+(2*(box1W+marginW)),marginSH,box1W/2,scopeH), s);
			freq3.freqMode_(1);
			freq3.inBus_(busNum+4);
			freq3.server_(s);
			freq3.active_(true);
			freq3.scope.visible = true;
			freq3.background_(Color.black);
			freq3.waveColors_([Color.fromHexString("#d4af37")])}.defer(0.2);
		};
		if(buttonScope3.value == 0){
			{freq3.active_(false);
			freq3.scope.visible = false;
			freq3.kill;
			scope3.start}.defer(0.2);
		};
	});

buttonScope4 = Button.new(window,Rect(margin2W+(box1W/9.5)+(3*(box1W+marginW)),marginSH,box1W/9.5,box1H/4)).states_([["t",Color.black,Color.fromHexString("#d4af37")],["f",Color.black,Color.fromHexString("#d4af37")]]).font_(Font("Monotype Corsiva", fontL));

buttonScope4.action_({
		if(buttonScope4.value == 1){
			{scope4.stop;
			freq4 = FreqScopeView.new(window, Rect(margin2W+(box1W/4.5)+(3*(box1W+marginW)),marginSH,box1W/2,scopeH), s);
			freq4.freqMode_(1);
			freq4.inBus_(busNum+6);
			freq4.server_(s);
			freq4.active_(true);
			freq4.scope.visible = true;
			freq4.background_(Color.black);
			freq4.waveColors_([Color.fromHexString("#d4af37")])}.defer(0.2);
		};
		if(buttonScope4.value == 0){
			{freq4.active_(false);
			freq4.scope.visible = false;
			freq4.kill;
			scope4.start}.defer(0.2);
		};
	});


SynthDef(\scoping, {
    arg bus, buff;
    ScopeOut2.ar(inputArray: In.ar(bus,2), scopeNum: buff, maxFrames: 8092, scopeFrames: 1024);
    Out.ar([0,1], In.ar(bus, 2));
	Out.ar((bus+10), In.ar(bus, 1)+In.ar(bus+1, 1));
  }).add;

{~scope1 = Synth(\scoping, [\buff, f1.bufnum, \bus, busNum])}.defer(0.1);
{~scope2 = Synth(\scoping, [\buff, f2.bufnum, \bus, busNum+2])}.defer(0.1);
{~scope3 = Synth(\scoping, [\buff, f3.bufnum, \bus, busNum+(2*2)])}.defer(0.1);
{~scope4 = Synth(\scoping, [\buff, f4.bufnum, \bus, busNum+(3*2)])}.defer(0.1);

button_1_1_1.action_{ |b|
		if(b.value == 1,
			{{~play1 = Synth(\rat1,[\mix,knob_1_1_2.value,\room,knob_1_1_3.value,\damp,knob_1_1_4.value,\amp,slider1_1.value/100,\pan,slider1_2.value,\rat,knob_1_2_4.value,\tickSpeed,knob_1_2_2.value, \pos, knob_1_2_3.value])}.defer(0.1)},
			{~play1.free}
		);
	};
	button_2_1_1.action_{ |b|
		if(b.value == 1,
			{{~play2 = Synth(\rat2,[\mix,knob_1_1_2.value,\room,knob_1_1_3.value,\damp,knob_1_1_4.value,\amp,slider2_1.value/100,\pan,slider2_2.value,\tickSpeed,knob_2_2_2.value,\rat,knob_2_2_4.value,\pos,knob_2_2_3.value])}.defer(0.1)},
			{~play2.free}
		);
	};
	button_3_1_1.action_{ |b|
		{~play3 = Synth(\rat3,[\mix,knob_1_1_2.value,\room,knob_1_1_3.value,\damp,knob_1_1_4.value,\amp,slider3_1.value/100,\pan,slider3_2.value,\rat,knob_3_2_4.value,\len,knob_3_2_2.value,\pos,knob_3_2_3.value])}.defer(0.1)}
	;
	button_4_1_1.action_{ |b|
		if(b.value == 1,
			{{~play4 = Synth(\rat4,[\mix,knob_1_1_2.value,\room,knob_1_1_3.value,\damp,knob_1_1_4.value,\amp,slider4_1.value/100,\pan,slider4_2.value,\pos,knob_4_2_3.value,\rat,knob_4_2_4.value,\dens,knob_4_2_2.value])}.defer(0.1)},
			{~play4.free}
		);
	};

	//VOLUME SLIDERS

	slider1_1.action_{ |s|
		~play1.set(\amp,s.value/100);};

	slider2_1.action_{ |s|
		~play2.set(\amp,s.value/100)};

	slider3_1.action_{ |s|
		~play3.set(\amp,s.value/100)};

	slider4_1.action_{ |s|
		~play4.set(\amp,s.value/100)};

	//PAN SLIDERS


	slider1_2.action_{ |s|
		~play1.set(\pan,s.value);
	};

	slider2_2.action_{ |s|
		~play2.set(\pan,s.value)};

	slider3_2.action_{ |s|
		~play3.set(\pan,s.value)};

	slider4_2.action_{ |s|
		~play4.set(\pan,s.value)};

	//REVERB
	knob_1_1_2.action_{ |k|
		~play1.set(\mix,k.value)};

	knob_1_1_3.action_{ |k|
		~play1.set(\room,k.value)};

	knob_1_1_4.action_{ |k|
		~play1.set(\damp,k.value)};

	knob_2_1_2.action_{ |k|
		~play2.set(\mix,k.value)};

	knob_2_1_3.action_{ |k|
		~play2.set(\room,k.value)};

	knob_2_1_4.action_{ |k|
		~play2.set(\damp,k.value)};

	knob_3_1_2.action_{ |k|
		~play3.set(\mix,k.value)};

	knob_3_1_3.action_{ |k|
		~play3.set(\room,k.value)};

	knob_3_1_4.action_{ |k|
		~play3.set(\damp,k.value)};

	knob_4_1_2.action_{ |k|
		~play4.set(\mix,k.value)};

	knob_4_1_3.action_{ |k|
		~play4.set(\room,k.value)};

	knob_4_1_4.action_{ |k|
		~play4.set(\damp,k.value)};

	//SOUND1
	knob_1_2_2.action_{ |k|
		~play1.set(\tickSpeed,k.value)};
	knob_1_2_3.action_{ |k|
		~play1.set(\pos,k.value)};
	knob_1_2_4.action_{ |k|
		~play1.set(\rat,k.value)};

	//SOUND2
	knob_2_2_2.action_{ |k|
		~play2.set(\tickSpeed,k.value)};
	knob_2_2_3.action_{ |k|
		~play2.set(\pos,k.value)};
	knob_2_2_4.action_{ |k|
		~play2.set(\rat,k.value)};

	//SOUND3
	knob_3_2_2.action_{ |k|
		~play3.set(\len,k.value)};
	knob_3_2_3.action_{ |k|
		~play3.set(\pos,k.value)};
	knob_3_2_4.action_{ |k|
		~play3.set(\rat,k.value)};

	//SOUND4
	knob_4_2_2.action_{ |k|
		~play4.set(\dens,k.value)};
	knob_4_2_3.action_{ |k|
		~play4.set(\pos,k.value)};
	knob_4_2_4.action_{ |k|
		~play4.set(\rat,k.value)};
});
)