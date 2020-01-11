//
//  HealthManager.swift
//  Health
//
//  Created by miaokii on 2020/1/11.
//  Copyright © 2020 ly. All rights reserved.
//

import Foundation
import HealthKit

/// 权限协议
protocol PermissionProtocol {
    /// 通过
    var isAuthorized: Bool { get }
    /// 拒绝
    var isDenied: Bool { get }
    /// 请求权限
    func request(completion: @escaping ()->()?)
}

class HealthManager {
    
    private var healthStore: HKHealthStore!
    private var dataSet: [DataType] = [.sports, .hrm, .kg, .oxy, .sleep, .glu, .tem, .bpm]
    private var sampleTypes: [HKSampleType]!
    static var share: HealthManager {
        struct SignleClass {
            static let instance = HealthManager.init()
        }
        return SignleClass.instance
    }
    
    // 支持健康数据
    static var supportHealthKit: Bool {
        return HKHealthStore.isHealthDataAvailable()
    }
    
    init() {
        healthStore = HKHealthStore.init()
        sampleTypes = [HKSampleType]()
        dataSet.forEach { (dataType) in
            if let sampleType = dataTypeToQuantityType(dataType) {
                sampleTypes.append(sampleType)
            }
        }
    }
    
    func readHealthData(type: DataType) -> [String: String] {
        switch type {
        case .sports:
            let stepType = HKObjectType.quantityType(forIdentifier: .stepCount)!
            let start = NSSortDescriptor.init(key: HKSampleSortIdentifierStartDate, ascending: false)
            let end = NSSortDescriptor.init(key: HKSampleSortIdentifierEndDate, ascending: false)
            
            /*
             + (NSPredicate *)getStepPredicateForSample {
                 NSDate *now = [NSDate date];
                 NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
                 [formatter setDateFormat:@"yyyyMMdd"];
                 NSString *startFormatValue = [NSString stringWithFormat:@"%@000000",[formatter stringFromDate:now]];
                 NSString *endFormatValue = [NSString stringWithFormat:@"%@235959",[formatter stringFromDate:now]];
                 [formatter setDateFormat:@"yyyyMMddHHmmss"];
                 NSDate * startDate = [formatter dateFromString:startFormatValue];
                 NSDate * endDate = [formatter dateFromString:endFormatValue];
                 NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionNone];
                 return predicate;
             }
             ————————————————
             版权声明：本文为CSDN博主「TechAlleyBoy」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
             原文链接：https://blog.csdn.net/TechAlleyBoy/article/details/72965387
             */
            
            let now = NSDate().
            
            
            HKSampleQuery.init(sampleType: stepType, predicate: heal, limit: <#T##Int#>, sortDescriptors: <#T##[NSSortDescriptor]?#>, resultsHandler: <#T##(HKSampleQuery, [HKSample]?, Error?) -> Void#>)
            /*

                 //要检索的数据类型。
                 HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];

                 //NSSortDescriptors用来告诉healthStore怎么样将结果排序。
                 NSSortDescriptor *start = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:NO];
                 NSSortDescriptor *end = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierEndDate ascending:NO];

                 /*
                  @param         sampleType      要检索的数据类型。
                  @param         predicate       数据应该匹配的基准。
                  @param         limit           返回的最大数据条数
                  @param         sortDescriptors 数据的排序描述
                  @param         resultsHandler  结束后返回结果
                  */
                 HKSampleQuery*query = [[HKSampleQuery alloc] initWithSampleType:stepType predicate:[HealthKitManager getStepPredicateForSample] limit:HKObjectQueryNoLimit sortDescriptors:@[start,end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
                     if(error){
                         completion(0,error);
                     }else{
                         NSLog(@"resultCount = %ld result = %@",results.count,results);
                         //把结果装换成字符串类型
                         double totleSteps = 0;
                         for(HKQuantitySample *quantitySample in results){
                             HKQuantity *quantity = quantitySample.quantity;
                             HKUnit *heightUnit = [HKUnit countUnit];
                             double usersHeight = [quantity doubleValueForUnit:heightUnit];
                             totleSteps += usersHeight;
                         }
                         NSLog(@"最新步数：%ld",(long)totleSteps);
                         completion([NSString stringWithFormat:@"%ld",(long)totleSteps],error);
                     }
                 }];
                 [self.healthStore executeQuery:query];
             ————————————————
             版权声明：本文为CSDN博主「TechAlleyBoy」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
             原文链接：https://blog.csdn.net/TechAlleyBoy/article/details/72965387
             */
        case .hrm:
            return [:]
        default:
            return [:]
        }
    }
    
    private func dataTypeToQuantityType(_ type: DataType) -> HKSampleType? {
        switch type {
        case .bpm:
            return HKQuantityType.quantityType(forIdentifier: .bloodPressureSystolic)
        case .glu:
            return HKQuantityType.quantityType(forIdentifier: .bloodGlucose)
        case .hrm:
            return HKQuantityType.quantityType(forIdentifier: .heartRate)
        case .kg:
            return HKQuantityType.quantityType(forIdentifier: .bodyMass)
        case .oxy:
            return HKQuantityType.quantityType(forIdentifier: .oxygenSaturation)
        case .tem:
            return HKQuantityType.quantityType(forIdentifier: .bodyTemperature)
        case .sleep:
            return HKQuantityType.categoryType(forIdentifier: .sleepAnalysis)
        case .sports:
            return HKCategoryType.quantityType(forIdentifier: .stepCount)
        default:
            return nil
        }
    }
}

extension HealthManager: PermissionProtocol {
    var isAuthorized: Bool {
        guard sampleTypes.count > 0 else {
            return false
        }
        for sampleType in sampleTypes {
            if healthStore.authorizationStatus(for: sampleType) != .sharingAuthorized {
                return false
            }
        }
        return true
    }
    
    var isDenied: Bool {
        return !isAuthorized
    }
    
    func request(completion: @escaping () -> ()?) {
        let sampleSet = Set.init(sampleTypes)
        healthStore.requestAuthorization(toShare: sampleSet, read: sampleSet) { (success, error) in
            if let error = error {
                print(error)
            }
            completion()
        }
    }
}

enum DataType: String {
    /// 运动
    case sports = "sport"
    /// 血压
    case bpm = "bpm"
    /// 血糖
    case glu = "bgm"
    /// 心率
    case hrm = "heart"
    /// 血氧
    case oxy = "oxy"
    /// 体重
    case kg = "weight"
    /// 睡眠
    case sleep = "sleep"
    /// 体温
    case tem = "tem"

    /// 定位
    case location = "loc"
}
