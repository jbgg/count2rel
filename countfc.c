
#include <data.h>
#include <types.h>

extern uint64_t count;

void countf(uint8_t *p, uint64_t i){

    /* base case */
	if(i >= (2*N)){
		count++;
		return;
	}

	/* else i < 2*N */

	uint64_t j;
	uint64_t q;
	uint8_t n;
	uint8_t min = 0;
	do{
		q = 0;
		for(j=0;j<i;j++){
			if(p[j] == min){
				min++;
				q = 1;
                //break;
			}
		}
	}while(q);

	p[i++] = min;

	for(n=min+1;n<(2*N);n++){
		q=1;
		for(j=1;j<i;j++){
			if(p[j] == n){
				q = 0;
				break;
			}
		}
		if(q){
			p[i] = n;
			countf(p, i+1);
		}
	}
}

