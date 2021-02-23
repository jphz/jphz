#include <arpa/inet.h>
#include <netinet/in.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define MAXLINE 128
#define SERV_PORT 8001

void* ReadThread(void* arg) {
    pthread_detach(pthread_self());
    int sockfd = (long)arg;
    int n = 0;
    char buf[MAXLINE];
    while (1) {
        n = read(sockfd, buf, MAXLINE);
        if (n == 0) {
            printf("the other side has been closed.\n");
            close(sockfd);
            exit(0);
        } else {
            write(STDOUT_FILENO, buf, n);
        }
    }

    return (void*)0;
}

int main(int argc, char* argv[]) {
    struct sockaddr_in servaddr;
    int sockfd;
    char buf[MAXLINE];
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    bzero(&servaddr, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    inet_pton(AF_INET, "127.0.0.1", &servaddr.sin_addr);
    servaddr.sin_port = htons(SERV_PORT);
    connect(sockfd, (struct sockaddr*)&servaddr, sizeof(servaddr));

    pthread_t thid;
    pthread_create(&thid, NULL, ReadThread, (void*)sockfd);
    while (fgets(buf, MAXLINE, stdin) != NULL) {
        write(sockfd, buf, strlen(buf));
    }
    close(sockfd);
    return 0;
}
