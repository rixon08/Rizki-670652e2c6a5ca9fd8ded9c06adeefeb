class BasePresenter<T>{
  T view;
  void attachView(T view){
    this.view = view;
  }

  void detachView(){
    view = null;
  }

  bool isViewAttached(){
    return view != null;
  }

  void checkViewAttached(){
    if(view == null){
      throw new Exception("View is null");
    }
  }

  T getView(){
    return view;
  }
}