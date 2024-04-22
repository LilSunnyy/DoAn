import AppFooter from '@/components/footer/app.footer';
import AppHeader from '@/components/header/app.header';
import ThemeRegistry from '@/components/theme-registry/theme.registry';
import { CourseContextProvider } from '@/lib/course.wrapper';
import NextAuthWrapper from '@/lib/next.auth.wrapper';
import NProgressWrapper from '@/lib/nprgress.wrapper';
import { ToastProvider } from '@/utils/toast';

const DRAWER_WIDTH = 240;

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body>
        <ThemeRegistry>
          <NProgressWrapper>
            <NextAuthWrapper>
              <ToastProvider>
                <CourseContextProvider>
                  {children}
                </CourseContextProvider>
              </ToastProvider>
            </NextAuthWrapper>
          </NProgressWrapper>
        </ThemeRegistry>
      </body>
    </html>
  );
}
