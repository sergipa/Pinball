#ifndef __j1PHYSICS_H__
#define __j1PHYSICS_H__

#include "j1Module.h"
#include "Box2D/Box2D/Box2D.h"

#define PIXELS_PER_METER 50.0f // if touched change METER_PER_PIXEL too
#define METER_PER_PIXEL 0.02f // this is 1 / PIXELS_PER_METER !

#define METERS_TO_PIXELS(m) ((int) floor(PIXELS_PER_METER * m))
#define PIXEL_TO_METERS(p)  ((float) METER_PER_PIXEL * p)

struct SDL_Texture;

class PhysBody
{
public:
	PhysBody() : listener(NULL), body(NULL)
	{}

	void GetPosition(int& x, int &y) const;
	float GetRotation() const;
	bool Contains(int x, int y) const;
	int RayCast(int x1, int y1, int x2, int y2, float& normal_x, float& normal_y) const;

public:
	int width, height;
	b2Body* body;
	j1Module* listener;
};

class j1Physics : public j1Module, public b2ContactListener
{
public:

	j1Physics();

	// Destructor
	~j1Physics();

	// Called before render is available
	bool Awake();

	// Called before the first frame
	bool Start();

	// Called before all Updates
	bool PreUpdate();

	// Called each loop iteration
	bool Update(float dt);

	// Called before all Updates
	bool PostUpdate();

	// Called before quitting
	bool CleanUp();

	PhysBody* CreateCircle(int x, int y, int radius,b2BodyType type, uint16 mask, uint16 category);
	PhysBody* CreateRectangle(int x, int y, int width, int height);
	PhysBody* CreateRectangleSensor(int x, int y, int width, int height);
	PhysBody* CreateChain(int x, int y, int* points, int size, uint16 mask, uint16 category);
	PhysBody* CreatePrismaticJoint(PhysBody* Rectangle, int lower, int max, int maxMotor, int motorSpeed);
	b2RevoluteJoint* CreateRevoluteJoint(int radius, int width, int height, int posx, int posy, int despacement, int upper_angle, int lower_angle, int max_torque, int speed, uint16 mask, uint16 category);
	b2RevoluteJoint* CreateRevoluteJointPoly(int radius, int* points, int size, int posx, int posy, int despacement_x,int despacement_y, int upper_angle, int lower_angle, int max_torque, int speed, uint16 mask, uint16 category);

	// b2ContactListener ---
	void BeginContact(b2Contact* contact);

private:

	bool debug;
	b2World* world;
	b2MouseJoint* mouse_joint;
	b2Body* ground;
};

#endif // __j1PHYSICS_H__