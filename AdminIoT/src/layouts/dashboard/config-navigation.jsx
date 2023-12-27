import SvgColor from 'src/components/svg-color';

// ----------------------------------------------------------------------

const icon = (name) => (
  <SvgColor src={`/assets/icons/navbar/${name}.svg`} sx={{ width: 1, height: 1 }} />
);

const navConfig = [
  {
    title: 'Trang chủ',
    path: '/',
    icon: icon('ic_analytics'),
  },
  {
    title: 'Công ty/Doanh nghiệp',
    path: '/company',
    icon: icon('company'),
  },
  {
    title: 'Quản lý tài khoản',
    path: '/user',
    icon: icon('ic_user'),
  },
  {
    title: 'Quản lý chấm công',
    path: '/attendance',
    icon: icon('log'),
  },
  {
    title: 'Tài khoản',
    path: '/profile',
    icon: icon('settings'),
  },
  // {
  //   title: 'product',
  //   path: '/products',
  //   icon: icon('ic_cart'),
  // },
  // {
  //   title: 'Bài viết',
  //   path: '/blog',
  //   icon: icon('ic_blog'),
  // },
  // {
  //   title: 'Not found',
  //   path: '/404',
  //   icon: icon('ic_disabled'),
  // },
];

export default navConfig;
