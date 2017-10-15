import MainView    from './main';
import ZipIndexView from './page/users_index_view';

// Collection of specific view modules
const views = {
  UserIndexView
};

export default function loadView(viewName) {
  return views[viewName] || MainView;
}
