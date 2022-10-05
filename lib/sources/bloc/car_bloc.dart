import 'package:car_world_system/sources/model/car.dart';
import 'package:car_world_system/sources/model/car_generation.dart';
import 'package:car_world_system/sources/repository/car_repository.dart';
import 'package:rxdart/rxdart.dart';

class CarBloc {
  final CarRepository carRepository = CarRepository();
  final _listCarFetcher = PublishSubject<List<Car>>();
  final _carDetailFetcher = PublishSubject<List<Car>>();

 final _listCarGenerationFetcher = PublishSubject<List<CarGeneration>>();

  Observable<List<CarGeneration>> get listCarGeneration => _listCarGenerationFetcher.stream;
  Observable<List<Car>> get listCar => _listCarFetcher.stream;
  Observable<List<Car>> get carDetail => _carDetailFetcher.stream;
  //get list all car
  // getListCar() async {
  //   List<Car> listCar = await carRepository.getListcar();
  //   _listCarFetcher.sink.add(listCar);
  // }

  // //get list car by name
  // getListCarByName(String name) async {
  //   List<Car> listCarByName = await carRepository.getListCarByName(name);
  //   _listCarFetcher.sink.add(listCarByName);
  // }

  // //get list car by brand name
  // getListCarByBrandName(String brandName) async {
  //   List<Car> listCarByBrandName = await carRepository.getListCarByBrandName(brandName);
  //   _listCarFetcher.sink.add(listCarByBrandName);
  // }

  //get car detail by id
  getAccessoryDetail(String id) async {
    List<Car> carDetail = await carRepository.getCarDetail(id);
    _carDetailFetcher.sink.add(carDetail);
  }

getSearchCar(String id) async {
    List<CarGeneration> listCarByName = await carRepository.getSearchCar(id);
    _listCarGenerationFetcher.sink.add(listCarByName);
  }


  getAllCar() async {
    List<CarGeneration> listCarByName = await carRepository.getAllCar();
    _listCarGenerationFetcher.sink.add(listCarByName);
  }

   getAllCarByBrand(String id) async {
    List<CarGeneration> listCarByName = await carRepository.getAllCarByBrand(id);
    _listCarGenerationFetcher.sink.add(listCarByName);
  }
  dispose() {
    _listCarFetcher.close();
    _carDetailFetcher.close();
    _listCarGenerationFetcher.close();
  }
}

final carBloc = CarBloc();
