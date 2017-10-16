import MainView    from './main';
import UserIndexView from './page/users_index_view';

// Collection of specific view modules
const views = {
  UserIndexView
};

export default function loadView(viewName) {
  return views[viewName] || MainView;
}
