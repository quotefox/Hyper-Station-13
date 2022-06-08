#define BASEPAY_ASSISTANT 1
#define BASEPAY_ROOKIE 1.05	//rookies, chaplain, clown, curator, lawyer, etc that dont take much effort to be good in
#define BASEPAY_DEFAULT 1.1
#define BASEPAY_COMMAND 1.3
#define BASEPAY_CAPTAIN 1.65


#define PRICE_BASE		(FLOOR(BASEPAY_ASSISTANT * 16, 1))
#define PRICE_LOW		(FLOOR(PRICE_BASE * 0.5, 1))
#define PRICE_HIGH		(FLOOR(PRICE_BASE * 2, 1))
#define PRICE_EROTICA	(FLOOR(PRICE_HIGH * 1.15, 1))
#define PRICE_EXPENSIVE	(FLOOR(PRICE_HIGH * 1.5), 1)
