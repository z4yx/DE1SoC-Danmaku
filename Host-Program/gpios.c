#include "gpios.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <poll.h>
extern volatile int render_running, sigint;
extern volatile int button_ip_click;

void *Thread4Button(void *t) 
{
    struct pollfd fdset[1];
    int pin = -1;
    FILE* res = popen(
        "n=`ls /sys/devices/platform/soc/ff200000.fpga-bridge/ff2100c0.gpio/gpio`;"
        "n=${n#gpiochip};"
        "echo $n >/sys/class/gpio/export;"
        "echo falling >/sys/class/gpio/gpio$n/edge;"
        "echo $n","r");
    if(!res){
        printf("failed to get button GPIO pin\n");
        return -1;
    }
    fscanf(res, "%d", &pin);
    pclose(res);
    if(pin < 0){
        printf("wrong pin number\n");
        return -1;
    }
    printf("button pin=%d\n", pin);

    char buf[64];
    sprintf(buf, "/sys/class/gpio/gpio%d/value", pin);

    int fd = open(buf, O_RDONLY | O_NONBLOCK );
    if (fd < 0) {
        perror("gpio/fd_open");
        return -1;
    }
    fdset[0].fd = fd;
    fdset[0].events = POLLPRI;
    for(int firsttime=1;!sigint;){
        int rc = poll(fdset, 1, 1000);

        if (rc < 0) {
            printf("\npoll() failed!\n");
            break;
        }
      
        // if (rc == 0) {
        //     printf(".");
        // }
            
        if (fdset[0].revents & POLLPRI) {
            lseek(fdset[0].fd, 0, SEEK_SET);
            read(fdset[0].fd, buf, sizeof(buf));
            printf("\npoll() GPIO %d interrupt occurred\n", pin);
            if(!firsttime)
                button_ip_click = 1;
            firsttime = 0;
        }
    }
    close(fd);
    return 0;
}