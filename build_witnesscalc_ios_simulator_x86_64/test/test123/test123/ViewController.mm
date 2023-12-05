//
//  ViewController.m
//  test123
//
//  Created by yushihang on 2023/11/28.
//

#import "ViewController.h"
#import "witnesscalc_authV2.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self test];
}

/*
 const char *circuit_buffer,  unsigned long  circuit_size,
 const char *json_buffer,     unsigned long  json_size,
 char       *wtns_buffer,     unsigned long *wtns_size,
 char       *error_msg,       unsigned long  error_msg_maxsize)
 */
- (void)test {
    
    const char *circuit_buffer = "1234567890";
    unsigned long circuit_size = strlen(circuit_buffer) + 1;
    const char *json_buffer = "{}";
    unsigned long json_size = strlen(json_buffer) + 1;
    
    unsigned long wtns_size = 4 * 1024 * 1024;
    char wtns_buffer[wtns_size];
    
    unsigned long error_msg_maxsize = 1024;
    char error_msg[error_msg_maxsize];
    int res = witnesscalc_authV2(circuit_buffer, circuit_size-1, json_buffer, json_size-1, wtns_buffer, &wtns_size, error_msg, error_msg_maxsize);
    NSLog(@"res: %d", res);
    
}
@end
