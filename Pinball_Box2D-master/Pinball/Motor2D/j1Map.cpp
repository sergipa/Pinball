#include "p2Defs.h"
#include "p2Log.h"
#include "j1App.h"
#include "j1Render.h"
#include "j1FileSystem.h"
#include "j1Textures.h"
#include "j1Map.h"
#include <math.h>
#include "j1Physics.h"
#include "j1Input.h"

j1Map::j1Map() : j1Module()
{
	name.create("map");
}

// Destructor
j1Map::~j1Map()
{}

// Called before render is available
bool j1Map::Awake(pugi::xml_node& config)
{
	bool ret = true;


	return ret;
}

bool j1Map::PostUpdate() {
	if (App->input->GetKey(SDL_SCANCODE_SPACE) == KEY_DOWN) {
		b2Vec2 force(0.0f, -100.0f);
		b2Vec2 ball_pos(ball->pb->body->GetWorldCenter());
		ball->pb->body->ApplyForce(force, ball_pos,true);
	}
	return true;
}
bool j1Map::Start()
{
	bool ret = true;
	// Background
	bgBelow = new Sprite(App->tex->Load("images/BackgroundBelow.png"), 0, 0, 395, 537, 0, 0);
	bgAbove = new Sprite(App->tex->Load("images/Background.png"), 0, 0, 395, 537, 0, 0);
	//Ball
	ball = new Sprite(App->tex->Load("images/Ball.png"), 0, 0, 16, 16);

	//Kickers
	kickerLeft = new Sprite(App->tex->Load("images/kickerLeft.png"), 0, 0, 50, 31, 112, 485);
	kickerRight = new Sprite(App->tex->Load("images/kickerRight.png"), 0, 0, 50, 31, 193, 485);
	kickerTopRight = new Sprite(App->tex->Load("images/kickerRight.png"), 0, 0, 50, 31, 292, 267);

	//Bouncers
	bouncerLeft = new Sprite(App->tex->Load("images/bouncerIdle.png"), 0, 0, 39, 40, 106, 138);
	bouncerRight = new Sprite(App->tex->Load("images/bouncerIdle.png"), 0, 0, 39, 40, 216, 129);
	bouncerMid = new Sprite(App->tex->Load("images/bouncerIdle.png"), 0, 0, 39, 40, 161, 178);
	bouncersbgOn = new Sprite(App->tex->Load("images/3MidCerclesOn.png"), 0, 0, 179, 118, 89, 114);
	bouncersbgOff = new Sprite(App->tex->Load("images/3MidCerclesOff.png"), 0, 0, 179, 118, 89, 114);
	bouncerHitLeft = new Sprite(App->tex->Load("images/bouncerHit.png"), 0, 0, 39, 39, 0, 0);
	bouncerHitRight = new Sprite(App->tex->Load("images/bouncerHit.png"), 0, 0, 39, 39, 0, 0);
	bouncerHitMid = new Sprite(App->tex->Load("images/bouncerHit.png"), 0, 0, 39, 39, 0, 0);
	bouncerBottomLeft = new Sprite(App->tex->Load("images/bouncerBottomLeft.png"), 0, 0, 56, 69, 66, 386);
	bouncerBottomRight = new Sprite(App->tex->Load("images/bouncerBottomRight.png"), 0, 0, 56, 69, 229, 386);
	bouncerBottomLeftStick = new Sprite(App->tex->Load("images/bouncerBottomLeftStick.png"), 0, 0, 52, 60, 72, 388);
	bouncerBottomRightStick = new Sprite(App->tex->Load("images/bouncerBottomRightStick.png"), 0, 0, 52, 60, 228, 387);

	//Scene stuff
	cercleBelowMidGirl = new Sprite(App->tex->Load("images/midCercleOff.png"), 0, 0, 221, 146, 67, 231);
	midGirl = new Sprite(App->tex->Load("images/midGirl.png"), 0, 0, 115, 213, 122, 171);
	midBoys = new Sprite(App->tex->Load("images/2midGuys.png"), 0, 0, 325, 222, 16, 315);
	multiBallIndicator = new Sprite(App->tex->Load("images/multiBallOff.png"), 0, 0, 36, 36, 80, 326);
	superFreakIndicator = new Sprite(App->tex->Load("images/superFreakOff.png"), 0, 0, 36, 36, 235, 327);
	bottomHalfCercleLeft = new Sprite(App->tex->Load("images/bottomHalfCercle.png"), 0, 0, 118, 79, 6, 451);
	bottomHalfCercleRight = new Sprite(App->tex->Load("images/bottomHalfCercle.png"), 0, 0, 118, 79, 234, 450);
	superFreakActivator1 = new Sprite(App->tex->Load("images/superFreakActivator.png"), 0, 0, 20, 21, 13, 319);
	superFreakActivator2 = new Sprite(App->tex->Load("images/superFreakActivatorRight.png"), 0, 0, 21, 19, 295, 299);
	superFreakActivator3 = new Sprite(App->tex->Load("images/superFreakActivatorRight.png"), 0, 0, 21, 19, 316, 318);
	superFreakActivator4 = new Sprite(App->tex->Load("images/superFreakActivatorTop.png"), 0, 0, 22, 16, 59, 116);
	superFreakActivator5 = new Sprite(App->tex->Load("images/superFreakActivatorTop.png"), 0, 0, 22, 16, 87, 104);
	oldFace = new Sprite(App->tex->Load("images/oldFaceTopRight.png"), 0, 0, 62, 69, 263, 65);
	mid1xBlue = new Sprite(App->tex->Load("images/mid1xBlue.png"), 0, 0, 32, 32, 161, 375);
	mid2x = new Sprite(App->tex->Load("images/mid2xBrown.png"), 0, 0, 32, 32, 161, 336);
	mid4x = new Sprite(App->tex->Load("images/mid4xBrown.png"), 0, 0, 32, 32, 161, 298);
	big5xOff = new Sprite(App->tex->Load("images/big5xOff.png"), 0, 0, 34, 34, 161, 114);
	x2IndicatorOff = new Sprite(App->tex->Load("images/2xOff.png"), 0, 0, 18, 18, 34, 281);
	x3IndicatorOff = new Sprite(App->tex->Load("images/3xOff.png"), 0, 0, 18, 18, 25, 257);
	x4IndicatorOff = new Sprite(App->tex->Load("images/4xOff.png"), 0, 0, 18, 18, 20, 233);
	x2Indicator2Off = new Sprite(App->tex->Load("images/2xOff.png"), 0, 0, 18, 18, 14, 87);
	x3Indicator2Off = new Sprite(App->tex->Load("images/3xOff.png"), 0, 0, 18, 18, 14, 61);
	x4Indicator2Off = new Sprite(App->tex->Load("images/4xOff.png"), 0, 0, 18, 18, 25, 40);
	x2Indicator3Off = new Sprite(App->tex->Load("images/2xOff.png"), 0, 0, 18, 18, 312, 147);
	x3Indicator3Off = new Sprite(App->tex->Load("images/3xOff.png"), 0, 0, 18, 18, 316, 120);
	x4Indicator3Off = new Sprite(App->tex->Load("images/4xOff.png"), 0, 0, 18, 18, 322, 95);
	rail = new Sprite(App->tex->Load("images/Rail.png"), 0, 0, 66, 160, 14, 74);
	rightBlueActivator1 = new Sprite(App->tex->Load("images/rightBlueActivator.png"), 0, 0, 18, 21, 328, 223);
	rightBlueActivator2 = new Sprite(App->tex->Load("images/rightBlueActivator.png"), 0, 0, 18, 21, 325, 203);
	rightBlueActivator3 = new Sprite(App->tex->Load("images/rightBlueActivator.png"), 0, 0, 18, 21, 322, 182);
	rightArrow = new Sprite(App->tex->Load("images/topRightArrowIdle.png"), 0, 0, 29, 36, 294, 165);
	doubleArrow = new Sprite(App->tex->Load("images/doubleArrow.png"), 0, 0, 35, 60, 28, 114);

	//Letters
	superFreakYellow_S = new Sprite(App->tex->Load("images/superFreakYellow_S.png"), 0, 0, 18, 18, 53, 173);
	superFreakYellow_U = new Sprite(App->tex->Load("images/superFreakYellow_U.png"), 0, 0, 18, 18, 62, 193);
	superFreakYellow_P = new Sprite(App->tex->Load("images/superFreakYellow_P.png"), 0, 0, 18, 18, 72, 214);
	superFreakYellow_E = new Sprite(App->tex->Load("images/superFreakYellow_E.png"), 0, 0, 18, 18, 81, 236);
	superFreakYellow_R = new Sprite(App->tex->Load("images/superFreakYellow_R.png"), 0, 0, 18, 18, 90, 258);
	superFreakYellow_F = new Sprite(App->tex->Load("images/superFreakYellow_F.png"), 0, 0, 18, 18, 289, 199);
	superFreakYellow_R2 = new Sprite(App->tex->Load("images/superFreakYellow_R.png"), 0, 0, 18, 18, 280, 222);
	superFreakYellow_E2 = new Sprite(App->tex->Load("images/superFreakYellow_E.png"), 0, 0, 18, 18, 270, 246);
	superFreakYellow_A = new Sprite(App->tex->Load("images/superFreakYellow_A.png"), 0, 0, 18, 18, 261, 267);
	superFreakYellow_K = new Sprite(App->tex->Load("images/superFreakYellow_K.png"), 0, 0, 18, 18, 252, 288);
	superFreakYellow_S2 = new Sprite(App->tex->Load("images/superFreakYellow_S.png"), 0, 0, 18, 18, 23, 330);
	superFreakYellow_U2 = new Sprite(App->tex->Load("images/superFreakYellow_U.png"), 0, 0, 18, 18, 68, 126);
	superFreakYellow_P2 = new Sprite(App->tex->Load("images/superFreakYellow_P.png"), 0, 0, 18, 18, 94, 114);
	superFreakYellow_E3 = new Sprite(App->tex->Load("images/superFreakYellow_E.png"), 0, 0, 18, 18, 289, 309);
	superFreakYellow_R3 = new Sprite(App->tex->Load("images/superFreakYellow_R.png"), 0, 0, 18, 18, 311, 328);

	return ret;
}

void j1Map::CreateColliders()
{

	// Background standalone colliders
	int background[112] = {
		355, 527,
		374, 527,
		374, 68,
		366, 50,
		354, 36,
		337, 27,
		324, 24,
		52, 24,
		35, 31,
		20, 45,
		11, 64,
		9, 81,
		12, 101,
		19, 120,
		25, 135,
		37, 161,
		50, 190,
		58, 209,
		66, 229,
		69, 244,
		67, 257,
		61, 269,
		55, 278,
		44, 294,
		33, 310,
		22, 320,
		10, 333,
		10, 451,
		116, 532,
		116, 600,
		237, 600,
		240, 530,
		341, 452,
		341, 333,
		297, 296,
		339, 278,
		329, 184,
		341, 97,
		339, 80,
		331, 66,
		319, 55,
		301, 50,
		273, 52,
		259, 60,
		248, 77,
		246, 89,
		243, 100,
		235, 100,
		235, 47,
		237, 42,
		308, 42,
		319, 45,
		332, 50,
		342, 56,
		350, 68,
		355, 80
	};
	PhysBody* colliderb1 = App->physics->CreateChain(0, 0, background, 112, 0x0001, 0x0002);
	colliderb1->body->SetType(b2_staticBody);

	int background2[20] = {
		39, 398,
		41, 395,
		45, 395,
		47, 397,
		48, 433,
		118, 479,
		115, 484,
		112, 487,
		108, 491,
		39, 438
	};
	PhysBody* colliderb2 = App->physics->CreateChain(0, 0, background2, 20, 0x0001, 0x0002);
	colliderb2->body->SetType(b2_staticBody);

	int background3[20] = {
		312-3, 398,
		314-3, 395,
		317-3, 395,
		320-3, 398,
		320-3, 438,
		251, 491,
		248, 490,
		242, 483,
		243, 478,
		311-5, 434
	};
	PhysBody* colliderb3 = App->physics->CreateChain(0, 0, background3, 20, 0x0001, 0x0002);
	colliderb3->body->SetType(b2_staticBody);

	int background4[30] = {
		50, 122,
		119, 97,
		119, 45,
		107, 45,
		65, 46,
		55, 49,
		47, 53,
		40, 58,
		35, 64,
		31, 74,
		31, 82,
		32, 94,
		34, 99,
		39, 109,
		44, 116
	};

	PhysBody* colliderb4 = App->physics->CreateChain(0, 0, background4, 30, 0x0001, 0x0002);
	colliderb4->body->SetType(b2_staticBody);

	int background5[20] = {
		140, 96+3,
		140, 62+3,
		142, 59+3,
		145, 58+3,
		148, 59+3,
		150, 62+3,
		150, 96+3,
		148, 99+3,
		144, 100+3,
		142, 99+3
	};
	PhysBody* colliderb5 = App->physics->CreateChain(0, 0, background5, 20, 0x0001, 0x0002);
	colliderb5->body->SetType(b2_staticBody);

	int background6[20] = {
		161+10, 96+3,
		161+10, 62+3,
		163+10, 59+3,
		166+10, 58+3,
		169+10, 59+3,
		171+10, 62+3,
		171+10, 96+3,
		169+10, 99+3,
		165+10, 100+3,
		163+10, 99+3
	};
	PhysBody* colliderb6 = App->physics->CreateChain(0, 0, background6, 20, 0x0001, 0x0002);
	colliderb6->body->SetType(b2_staticBody);

	int background7[20] = {
		191+12, 96+3,
		191+12, 62+3,
		193+12, 59+3,
		196+12, 58+3,
		199+12, 59+3,
		201+12, 62+3,
		201+12, 96+3,
		199+12, 99+3,
		195+12, 100+3,
		193+12, 99+3
	};
	PhysBody* colliderb7 = App->physics->CreateChain(0, 0, background7, 20, 0x0001, 0x0002);
	colliderb7->body->SetType(b2_staticBody);


	int kickerLeft[18] = {
		1, 8,
		2, 4,
		5, 1,
		10, 1,
		48, 25,
		49, 29,
		47, 31,
		38, 27,
		3, 13
	};
	int kickerRight[22] = {
		49, 8,
		47, 3,
		43, 1,
		39, 1,
		4, 23,
		1, 26,
		1, 30,
		3, 31,
		15, 26,
		45, 13,
		49, 11
	};
	bouncerLeft->pb = App->physics->CreateCircle(126, 153+6, 20, b2_staticBody, 0x0001, 0x0002);
	bouncerMid->pb = App->physics->CreateCircle(180, 198, 20, b2_staticBody, 0x0001, 0x0002);
	bouncerRight->pb = App->physics->CreateCircle(236,143+6, 20, b2_staticBody, 0x0001, 0x0002);
	//360,52 Default position
	ball->pb = App->physics->CreateCircle(365, 352, 7,b2_dynamicBody, 0x0002, 0x0001);

	left_kicker_coll = App->physics->CreateRevoluteJointPoly(7, kickerLeft, 18, 119, 490, 10, 10, 60, -2, 20, 0, 0x0001, 0x0002);

	right_low_kicker_coll = App->physics->CreateRevoluteJointPoly(7, kickerRight, 22, 234, 490, 38, 8, 2, -60, 20, 0, 0x0001, 0x0002);

	right_top_kicker_coll = App->physics->CreateRevoluteJointPoly(7, kickerRight, 22, 332, 274, 38, 8, 2, -60, 20, 0, 0x0001, 0x0002);
}

void j1Map::Draw()
{
	Blit(bgBelow->texture, bgBelow->pos.x, bgBelow->pos.y, &bgBelow->rect);
	Blit(cercleBelowMidGirl->texture, cercleBelowMidGirl->pos.x, cercleBelowMidGirl->pos.y, &cercleBelowMidGirl->rect);
	Blit(bouncersbgOn->texture, bouncersbgOn->pos.x, bouncersbgOn->pos.y, &bouncersbgOn->rect);
	Blit(midGirl->texture, midGirl->pos.x, midGirl->pos.y, &midGirl->rect);
	Blit(bottomHalfCercleRight->texture, bottomHalfCercleRight->pos.x, bottomHalfCercleRight->pos.y, &bottomHalfCercleRight->rect);
	Blit(bottomHalfCercleLeft->texture, bottomHalfCercleLeft->pos.x, bottomHalfCercleLeft->pos.y, &bottomHalfCercleLeft->rect);
	Blit(midBoys->texture, midBoys->pos.x, midBoys->pos.y, &midBoys->rect);
	Blit(mid1xBlue->texture, mid1xBlue->pos.x, mid1xBlue->pos.y, &mid1xBlue->rect);
	Blit(mid2x->texture, mid2x->pos.x, mid2x->pos.y, &mid2x->rect);
	Blit(mid4x->texture, mid4x->pos.x, mid4x->pos.y, &mid4x->rect);
	Blit(big5xOff->texture, big5xOff->pos.x, big5xOff->pos.y, &big5xOff->rect);
	Blit(multiBallIndicator->texture, multiBallIndicator->pos.x, multiBallIndicator->pos.y, &multiBallIndicator->rect);
	Blit(superFreakIndicator->texture, superFreakIndicator->pos.x, superFreakIndicator->pos.y, &superFreakIndicator->rect);
	Blit(rightBlueActivator1->texture, rightBlueActivator1->pos.x, rightBlueActivator1->pos.y, &rightBlueActivator1->rect);
	Blit(rightBlueActivator2->texture, rightBlueActivator2->pos.x, rightBlueActivator2->pos.y, &rightBlueActivator2->rect);
	Blit(rightBlueActivator3->texture, rightBlueActivator3->pos.x, rightBlueActivator3->pos.y, &rightBlueActivator3->rect);
	Blit(bgAbove->texture, bgAbove->pos.x, bgAbove->pos.y, &bgAbove->rect);
	Blit(kickerLeft->texture, kickerLeft->pos.x, kickerLeft->pos.y, &kickerLeft->rect);
	Blit(kickerRight->texture, kickerRight->pos.x, kickerRight->pos.y, &kickerRight->rect);
	Blit(kickerTopRight->texture, kickerTopRight->pos.x, kickerTopRight->pos.y, &kickerTopRight->rect);
	Blit(bouncerLeft->texture, bouncerLeft->pos.x, bouncerLeft->pos.y, &bouncerLeft->rect);
	Blit(bouncerRight->texture, bouncerRight->pos.x, bouncerRight->pos.y, &bouncerRight->rect);
	Blit(bouncerMid->texture, bouncerMid->pos.x, bouncerMid->pos.y, &bouncerMid->rect);
	Blit(bouncerBottomLeftStick->texture, bouncerBottomLeftStick->pos.x, bouncerBottomLeftStick->pos.y, &bouncerBottomLeftStick->rect);
	Blit(bouncerBottomRightStick->texture, bouncerBottomRightStick->pos.x, bouncerBottomRightStick->pos.y, &bouncerBottomRightStick->rect);
	Blit(bouncerBottomLeft->texture, bouncerBottomLeft->pos.x, bouncerBottomLeft->pos.y, &bouncerBottomLeft->rect);
	Blit(bouncerBottomRight->texture, bouncerBottomRight->pos.x, bouncerBottomRight->pos.y, &bouncerBottomRight->rect);
	Blit(superFreakActivator1->texture, superFreakActivator1->pos.x, superFreakActivator1->pos.y, &superFreakActivator1->rect);
	Blit(superFreakActivator2->texture, superFreakActivator2->pos.x, superFreakActivator2->pos.y, &superFreakActivator2->rect);
	Blit(superFreakActivator3->texture, superFreakActivator3->pos.x, superFreakActivator3->pos.y, &superFreakActivator3->rect);
	Blit(superFreakActivator4->texture, superFreakActivator4->pos.x, superFreakActivator4->pos.y, &superFreakActivator4->rect);
	Blit(superFreakActivator5->texture, superFreakActivator5->pos.x, superFreakActivator5->pos.y, &superFreakActivator5->rect);
	Blit(oldFace->texture, oldFace->pos.x, oldFace->pos.y, &oldFace->rect);
	Blit(doubleArrow->texture, doubleArrow->pos.x, doubleArrow->pos.y, &doubleArrow->rect);
	Blit(rail->texture, rail->pos.x, rail->pos.y, &rail->rect);
	Blit(x2IndicatorOff->texture, x2IndicatorOff->pos.x, x2IndicatorOff->pos.y, &x2IndicatorOff->rect);
	Blit(x3IndicatorOff->texture, x3IndicatorOff->pos.x, x3IndicatorOff->pos.y, &x3IndicatorOff->rect);
	Blit(x4IndicatorOff->texture, x4IndicatorOff->pos.x, x4IndicatorOff->pos.y, &x4IndicatorOff->rect);
	Blit(x2Indicator2Off->texture, x2Indicator2Off->pos.x, x2Indicator2Off->pos.y, &x2Indicator2Off->rect);
	Blit(x3Indicator2Off->texture, x3Indicator2Off->pos.x, x3Indicator2Off->pos.y, &x3Indicator2Off->rect);
	Blit(x4Indicator2Off->texture, x4Indicator2Off->pos.x, x4Indicator2Off->pos.y, &x4Indicator2Off->rect);
	Blit(x2Indicator3Off->texture, x2Indicator3Off->pos.x, x2Indicator3Off->pos.y, &x2Indicator3Off->rect);
	Blit(x3Indicator3Off->texture, x3Indicator3Off->pos.x, x3Indicator3Off->pos.y, &x3Indicator3Off->rect);
	Blit(x4Indicator3Off->texture, x4Indicator3Off->pos.x, x4Indicator3Off->pos.y, &x4Indicator3Off->rect);
	Blit(rightArrow->texture, rightArrow->pos.x, rightArrow->pos.y, &rightArrow->rect);
	Blit(superFreakYellow_S->texture, superFreakYellow_S->pos.x, superFreakYellow_S->pos.y, &superFreakYellow_S->rect);
	Blit(superFreakYellow_U->texture, superFreakYellow_U->pos.x, superFreakYellow_U->pos.y, &superFreakYellow_U->rect);
	Blit(superFreakYellow_P->texture, superFreakYellow_P->pos.x, superFreakYellow_P->pos.y, &superFreakYellow_P->rect);
	Blit(superFreakYellow_E->texture, superFreakYellow_E->pos.x, superFreakYellow_E->pos.y, &superFreakYellow_E->rect);
	Blit(superFreakYellow_R->texture, superFreakYellow_R->pos.x, superFreakYellow_R->pos.y, &superFreakYellow_R->rect);
	Blit(superFreakYellow_F->texture, superFreakYellow_F->pos.x, superFreakYellow_F->pos.y, &superFreakYellow_F->rect);
	Blit(superFreakYellow_R2->texture, superFreakYellow_R2->pos.x, superFreakYellow_R2->pos.y, &superFreakYellow_R2->rect);
	Blit(superFreakYellow_E2->texture, superFreakYellow_E2->pos.x, superFreakYellow_E2->pos.y, &superFreakYellow_E2->rect);
	Blit(superFreakYellow_A->texture, superFreakYellow_A->pos.x, superFreakYellow_A->pos.y, &superFreakYellow_A->rect);
	Blit(superFreakYellow_K->texture, superFreakYellow_K->pos.x, superFreakYellow_K->pos.y, &superFreakYellow_K->rect);
	Blit(superFreakYellow_S2->texture, superFreakYellow_S2->pos.x, superFreakYellow_S2->pos.y, &superFreakYellow_S2->rect);
	Blit(superFreakYellow_U2->texture, superFreakYellow_U2->pos.x, superFreakYellow_U2->pos.y, &superFreakYellow_U2->rect);
	Blit(superFreakYellow_P2->texture, superFreakYellow_P2->pos.x, superFreakYellow_P2->pos.y, &superFreakYellow_P2->rect);
	Blit(superFreakYellow_E3->texture, superFreakYellow_E3->pos.x, superFreakYellow_E3->pos.y, &superFreakYellow_E3->rect);
	Blit(superFreakYellow_R3->texture, superFreakYellow_R3->pos.x, superFreakYellow_R3->pos.y, &superFreakYellow_R3->rect);
	Blit(ball->texture, METERS_TO_PIXELS(ball->pb->body->GetPosition().x - 8), METERS_TO_PIXELS(ball->pb->body->GetPosition().y - 8), &ball->rect);
}

// Called before quitting
bool j1Map::CleanUp()
{
	LOG("Unloading map");

	return true;
}

void j1Map::Blit(SDL_Texture * texture, int x, int y, const SDL_Rect* section)
{
	App->render->Blit(texture, x, y, section);
}




